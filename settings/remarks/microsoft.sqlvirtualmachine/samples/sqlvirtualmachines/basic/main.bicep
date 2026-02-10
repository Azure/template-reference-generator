param location string = 'westeurope'
@secure()
@description('The administrator password for the SQL virtual machine')
param vmAdminPassword string
param resourceName string = 'acctest0001'

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    disableTcpStateTracking: false
    dnsSettings: {
      dnsServers: []
    }
    ipConfigurations: [
      {
        properties: {
          primary: true
          privateIPAddress: '10.0.0.4'
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {}
          subnet: {}
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        name: 'testconfiguration1'
      }
    ]
    nicType: 'Standard'
    auxiliaryMode: 'None'
    enableAcceleratedNetworking: false
    enableIPForwarding: false
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
          destinationPortRange: '1433'
          priority: 1001
          protocol: 'Tcp'
          sourceAddressPrefixes: []
          sourcePortRange: '*'
          sourcePortRanges: []
          destinationAddressPrefix: '*'
          destinationAddressPrefixes: []
          destinationPortRanges: []
          direction: 'Inbound'
          sourceAddressPrefix: '167.220.255.0/25'
        }
      }
    ]
  }
}

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
    sqlManagement: 'Full'
    sqlServerLicenseType: 'PAYG'
    enableAutomaticUpgrade: true
    leastPrivilegeMode: 'Enabled'
    sqlImageOffer: 'SQL2017-WS2016'
    sqlImageSku: 'Developer'
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    osProfile: {
      computerName: 'winhost01'
      secrets: []
      windowsConfiguration: {
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
        }
        provisionVMAgent: true
        timeZone: 'Pacific Standard Time'
      }
      adminUsername: 'testadmin'
      adminPassword: vmAdminPassword
      allowExtensionOperations: true
    }
    storageProfile: {
      osDisk: {
        name: 'acctvm-250116171212663925OSDisk'
        writeAcceleratorEnabled: false
        deleteOption: 'Detach'
        diskSizeGB: 127
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        osType: 'Windows'
        caching: 'ReadOnly'
        createOption: 'FromImage'
      }
      dataDisks: []
      imageReference: {
        sku: 'SQLDEV'
        version: 'latest'
        offer: 'SQL2017-WS2016'
        publisher: 'MicrosoftSQLServer'
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
