param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the SQL virtual machine')
param vmAdminPassword string

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: resourceName
  properties: {
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
    disableTcpStateTracking: false
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'testconfiguration1'
        properties: {
          primary: true
          privateIPAddress: '10.0.0.4'
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
          subnet: {
            id: subnet.id
          }
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
      }
    ]
    nicType: 'Standard'
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: resourceName
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

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: resourceName
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    ipTags: []
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
}

resource sqlvirtualMachine 'Microsoft.SqlVirtualMachine/sqlVirtualMachines@2023-10-01' = {
  name: 'virtualMachine.name'
  properties: {
    enableAutomaticUpgrade: true
    leastPrivilegeMode: 'Enabled'
    sqlImageOffer: 'SQL2017-WS2016'
    sqlImageSku: 'Developer'
    sqlManagement: 'Full'
    sqlServerLicenseType: 'PAYG'
    virtualMachineResourceId: virtualMachine.id
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: resourceName
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_F2s'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
          properties: {
            primary: false
          }
        }
      ]
    }
    osProfile: {
      adminPassword: null
      adminUsername: 'testadmin'
      allowExtensionOperations: true
      computerName: 'winhost01'
      secrets: []
      windowsConfiguration: {
        enableAutomaticUpdates: true
        patchSettings: {
          assessmentMode: 'ImageDefault'
          patchMode: 'AutomaticByOS'
        }
        provisionVMAgent: true
        timeZone: 'Pacific Standard Time'
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
        caching: 'ReadOnly'
        createOption: 'FromImage'
        deleteOption: 'Detach'
        diskSizeGB: 127
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        name: 'acctvm-250116171212663925OSDisk'
        osType: 'Windows'
        writeAcceleratorEnabled: false
      }
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
  parent: virtualNetwork
  name: resourceName
  properties: {
    addressPrefix: '10.0.0.0/24'
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
  }
}
