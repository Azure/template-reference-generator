param location string = 'westeurope'
@secure()
@description('The administrator password for the SQL virtual machine')
param vmAdminPassword string
param resourceName string = 'acctest0001'

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    ipTags: []
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource sqlvirtualMachine 'Microsoft.SqlVirtualMachine/sqlVirtualMachines@2023-10-01' = {
  name: 'azapi_resource.virtualMachine.name'
  location: 'azapi_resource.virtualMachine.location'
  properties: {
    sqlServerLicenseType: 'PAYG'
    virtualMachineResourceId: virtualMachine.id
    enableAutomaticUpgrade: true
    leastPrivilegeMode: 'Enabled'
    sqlImageOffer: 'SQL2017-WS2016'
    sqlImageSku: 'Developer'
    sqlManagement: 'Full'
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    osProfile: {
      adminUsername: 'testadmin'
      adminPassword: vmAdminPassword
      allowExtensionOperations: true
      computerName: 'winhost01'
      secrets: []
      windowsConfiguration: {
        timeZone: 'Pacific Standard Time'
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
        }
        provisionVMAgent: true
      }
    }
    storageProfile: {
      dataDisks: []
      imageReference: {
        offer: 'SQL2017-WS2016'
        publisher: 'MicrosoftSQLServer'
        sku: 'SQLDEV'
        version: 'latest'
      }
      osDisk: {
        diskSizeGB: 127
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        name: 'acctvm-250116171212663925OSDisk'
        osType: 'Windows'
        writeAcceleratorEnabled: false
        caching: 'ReadOnly'
        createOption: 'FromImage'
        deleteOption: 'Detach'
      }
    }
    hardwareProfile: {
      vmSize: 'Standard_F2s'
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: false
          }
          id: networkInterface.id
        }
      ]
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.0.0/24'
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    disableTcpStateTracking: false
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        name: 'testconfiguration1'
        properties: {
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
          subnet: {
            id: subnet.id
          }
          primary: true
          privateIPAddress: '10.0.0.4'
        }
      }
    ]
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    securityRules: [
      {
        name: 'MSSQLRule'
        properties: {
          access: 'Allow'
          destinationAddressPrefix: '*'
          destinationAddressPrefixes: []
          destinationPortRange: '1433'
          destinationPortRanges: []
          direction: 'Inbound'
          priority: 1001
          protocol: 'Tcp'
          sourceAddressPrefix: '167.220.255.0/25'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
        }
      }
    ]
  }
}
