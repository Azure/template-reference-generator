param location string = 'westus'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string
param resourceName string = 'acctest0001'

var compName = 'resourceName'
var saName = 'saBase'
var saBase = 'resourcename'
var dnsLabel = 'resourcename'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: saName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    defaultToOAuthAuthentication: false
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        queue: {
          keyType: 'Service'
        }
        table: {
          keyType: 'Service'
        }
      }
    }
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
    publicNetworkAccess: 'Enabled'
    dnsEndpointType: 'Standard'
    isHnsEnabled: false
    isLocalUserEnabled: true
    isSftpEnabled: false
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowSharedKeyAccess: true
    isNfsV3Enabled: false
  }
}

resource vault 'Microsoft.RecoveryServices/vaults@2024-01-01' = {
  name: '${resourceName}-rsv'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    redundancySettings: {
      crossRegionRestore: 'Disabled'
      standardTierStorageRedundancy: 'GeoRedundant'
    }
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: '${resourceName}-vm'
  location: location
  properties: {
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
          properties: {
            primary: true
          }
        }
      ]
    }
    osProfile: {
      adminPassword: adminPassword
      adminUsername: 'vmadmin'
      computerName: compName
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }
    storageProfile: {
      dataDisks: [
        {
          createOption: 'Attach'
          diskSizeGB: 1023
          lun: 0
          managedDisk: {
            id: disk.id
            storageAccountType: 'Standard_LRS'
          }
          name: '${resourceName}-datadisk'
          writeAcceleratorEnabled: false
        }
        {
          createOption: 'Empty'
          diskSizeGB: 4
          lun: 1
          managedDisk: {
            storageAccountType: 'Standard_LRS'
          }
          name: '${resourceName}-datadisk2'
          writeAcceleratorEnabled: false
        }
      ]
      imageReference: {
        offer: '0001-com-ubuntu-server-jammy'
        publisher: 'Canonical'
        sku: '22_04-lts'
        version: 'latest'
      }
      osDisk: {
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        name: '${resourceName}-osdisk'
        writeAcceleratorEnabled: false
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: 'https://${saName}.blob.core.windows.net/'
      }
    }
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: '${resourceName}-vnet'
  location: location
  properties: {
    dhcpOptions: {
      dnsServers: []
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: []
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

resource protectedItem 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2023-02-01' = {
  name: 'VM;iaasvmcontainerv2;${resourceGroup().name};${virtualMachine.name}'
  properties: {
    extendedProperties: {
      diskExclusionProperties: {
        diskLunList: [
          0
        ]
        isInclusionList: true
      }
    }
    policyId: backupPolicy.id
    protectedItemType: 'Microsoft.Compute/virtualMachines'
    sourceResourceId: virtualMachine.id
  }
}

resource disk 'Microsoft.Compute/disks@2023-04-02' = {
  name: '${resourceName}-datadisk'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    creationData: {
      createOption: 'Empty'
    }
    diskSizeGB: 1023
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
    optimizedForFrequentAttach: false
    osType: null
    publicNetworkAccess: 'Enabled'
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: '${resourceName}-pip'
  location: location
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    dnsSettings: {
      domainNameLabel: '${dnsLabel}'
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2024-10-01' = {
  name: '${resourceName}-policy'
  parent: vault
  properties: {
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunDays: []
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2025-07-03T23:00:00Z'
      ]
    }
    tieringPolicy: {
      ArchivedRP: {
        duration: 0
        durationType: 'Invalid'
        tieringMode: 'DoNotTier'
      }
    }
    timeZone: 'UTC'
    backupManagementType: 'AzureIaasVM'
    policyType: 'V1'
    retentionPolicy: {
      dailySchedule: {
        retentionDuration: {
          count: 10
          durationType: 'Days'
        }
        retentionTimes: [
          '2025-07-03T23:00:00Z'
        ]
      }
      retentionPolicyType: 'LongTermRetentionPolicy'
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: '${resourceName}-subnet'
  parent: virtualNetwork
  properties: {
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.10.0/24'
    defaultOutboundAccess: true
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: '${resourceName}-nic'
  location: location
  properties: {
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'acctestipconfig'
        properties: {
          publicIPAddress: {}
          subnet: {}
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}
