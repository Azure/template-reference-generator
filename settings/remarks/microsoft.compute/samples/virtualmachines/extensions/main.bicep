param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
param vmAdminPassword string
param resourceName string = 'acctest0001'

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: resourceName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_F2'
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
      adminPassword: vmAdminPassword
      adminUsername: 'testadmin'
      computerName: 'hostname230630032848831819'
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }
    storageProfile: {
      imageReference: {
        offer: 'UbuntuServer'
        publisher: 'Canonical'
        sku: '16.04-LTS'
        version: 'latest'
      }
      osDisk: {
        name: 'myosdisk1'
        writeAcceleratorEnabled: false
        caching: 'ReadWrite'
        createOption: 'FromImage'
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
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
  }
}

resource extension 'Microsoft.Compute/virtualMachines/extensions@2023-03-01' = {
  name: resourceName
  location: location
  parent: virtualMachine
  properties: {
    autoUpgradeMinorVersion: false
    enableAutomaticUpgrade: false
    publisher: 'Microsoft.Azure.Extensions'
    settings: {
      commandToExecute: 'hostname'
    }
    suppressFailures: false
    type: 'CustomScript'
    typeHandlerVersion: '2.0'
  }
  tags: {
    environment: 'Production'
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    enableIPForwarding: false
    ipConfigurations: [
      {
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
        name: 'testconfiguration1'
      }
    ]
    enableAcceleratedNetworking: false
  }
}
