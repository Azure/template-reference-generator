param resourceName string = 'acctest0001'
param location string = 'westus'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

var saBase = substring(toLower(join(split(resourceName, '-'), '')), 0, 24)
var dnsLabel = substring(toLower(resourceName), 0, 63)
var compName = substring(resourceName, 0, 15)
var saName = saBase

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: saName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    dnsEndpointType: 'Standard'
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
    isHnsEnabled: false
    isLocalUserEnabled: true
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
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

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: '${resourceName}-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: []
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: '${resourceName}-subnet'
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.10.0/24'
    defaultOutboundAccess: true
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
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
    publicNetworkAccess: 'Enabled'
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
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
          subnet: {
            id: subnet.id
          }
        }
      }
    ]
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
      domainNameLabel: dnsLabel
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: '${resourceName}-vm'
  location: location
  properties: {
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: 'https://${saName}.blob.core.windows.net/'
      }
    }
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
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
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        name: '${resourceName}-osdisk'
        writeAcceleratorEnabled: false
      }
    }
  }
}

resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2024-10-01' = {
  name: '${resourceName}-policy'
  parent: vault
  properties: {
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
  }
}
