param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
param vmAdminPassword string

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'testconfiguration1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
  }
}

resource networkManager 'Microsoft.Network/networkManagers@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    description: ''
    networkManagerScopeAccesses: [
      'SecurityAdmin'
    ]
    networkManagerScopes: {
      managementGroups: []
      subscriptions: [
        '/subscriptions/${subscription().subscriptionId}'
      ]
    }
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: resourceName
  location: location
  properties: {
    osProfile: {
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
      adminPassword: vmAdminPassword
      adminUsername: 'testadmin'
      computerName: 'hostname230630032848831819'
    }
    storageProfile: {
      osDisk: {
        name: 'myosdisk1'
        writeAcceleratorEnabled: false
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
      imageReference: {
        publisher: 'Canonical'
        sku: '16.04-LTS'
        version: 'latest'
        offer: 'UbuntuServer'
      }
    }
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
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
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
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    delegations: []
  }
}

resource verifierWorkspace 'Microsoft.Network/networkManagers/verifierWorkspaces@2024-01-01-preview' = {
  name: resourceName
  location: location
  parent: networkManager
  properties: {
    description: 'A sample workspace'
  }
}

resource reachabilityAnalysisIntent 'Microsoft.Network/networkManagers/verifierWorkspaces/reachabilityAnalysisIntents@2024-01-01-preview' = {
  name: resourceName
  parent: verifierWorkspace
  properties: {
    sourceResourceId: virtualMachine.id
    description: 'A sample reachability analysis intent'
    destinationResourceId: virtualMachine.id
    ipTraffic: {
      destinationIps: [
        '10.4.0.1'
      ]
      destinationPorts: [
        '0'
      ]
      protocols: [
        'Any'
      ]
      sourceIps: [
        '10.4.0.0'
      ]
      sourcePorts: [
        '0'
      ]
    }
  }
}
