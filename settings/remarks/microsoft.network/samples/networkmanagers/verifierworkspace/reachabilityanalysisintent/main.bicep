@secure()
@description('The admin password for the virtual machine')
param adminPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The admin username for the virtual machine')
param adminUsername string

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
    description: 'A sample reachability analysis intent'
    destinationResourceId: virtualMachine.id
    ipTraffic: {
      sourcePorts: [
        '0'
      ]
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
    }
    sourceResourceId: virtualMachine.id
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

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
  }
}

resource reachabilityAnalysisRun 'Microsoft.Network/networkManagers/verifierWorkspaces/reachabilityAnalysisRuns@2024-01-01-preview' = {
  name: resourceName
  parent: verifierWorkspace
  properties: {
    description: 'A sample reachability analysis run'
    intentId: reachabilityAnalysisIntent.id
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    ipConfigurations: [
      {
        properties: {
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
        }
        name: 'testconfiguration1'
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}

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
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
      adminPassword: adminPassword
      adminUsername: adminUsername
      computerName: 'hostname230630032848831819'
    }
    storageProfile: {
      imageReference: {
        offer: 'UbuntuServer'
        publisher: 'Canonical'
        sku: '16.04-LTS'
        version: 'latest'
      }
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        name: 'myosdisk1'
        writeAcceleratorEnabled: false
      }
    }
  }
}
