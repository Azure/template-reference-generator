param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the SQL virtual machine')
param vmAdminPassword string

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
          assessmentMode: 'ImageDefault'
          patchMode: 'AutomaticByOS'
        }
        provisionVMAgent: true
      }
    }
    storageProfile: {
      imageReference: {
        offer: 'SQL2017-WS2016'
        publisher: 'MicrosoftSQLServer'
        sku: 'SQLDEV'
        version: 'latest'
      }
      osDisk: {
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        name: 'acctvm-250116171212663925OSDisk'
        writeAcceleratorEnabled: false
        caching: 'ReadOnly'
        createOption: 'FromImage'
        diskSizeGB: 127
        osType: 'Windows'
        deleteOption: 'Detach'
      }
      dataDisks: []
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
    ipConfigurations: [
      {
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        name: 'testconfiguration1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {}
          subnet: {}
          primary: true
          privateIPAddress: '10.0.0.4'
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
    auxiliarySku: 'None'
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    nicType: 'Standard'
    auxiliaryMode: 'None'
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
          destinationAddressPrefixes: []
          direction: 'Inbound'
          sourceAddressPrefixes: []
          access: 'Allow'
          destinationPortRange: '1433'
          destinationPortRanges: []
          priority: 1001
          protocol: 'Tcp'
          sourceAddressPrefix: '167.220.255.0/25'
          sourcePortRange: '*'
          sourcePortRanges: []
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}
