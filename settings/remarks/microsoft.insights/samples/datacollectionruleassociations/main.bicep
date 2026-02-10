param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: 'nic-230630033559397415'
  location: location
  properties: {
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'internal'
        properties: {
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
        }
      }
    ]
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: 'machine-230630033559397415'
  location: location
  properties: {
    osProfile: {
      adminPassword: adminPassword
      adminUsername: 'adminuser'
      allowExtensionOperations: true
      computerName: 'machine-230630033559397415'
      linuxConfiguration: {
        disablePasswordAuthentication: false
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
        provisionVMAgent: true
        ssh: {
          publicKeys: []
        }
      }
      secrets: []
    }
    storageProfile: {
      dataDisks: []
      imageReference: {
        publisher: 'Canonical'
        sku: '16.04-LTS'
        version: 'latest'
        offer: 'UbuntuServer'
      }
      osDisk: {
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        osType: 'Linux'
        writeAcceleratorEnabled: false
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    additionalCapabilities: {}
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
    priority: 'Regular'
    applicationProfile: {
      galleryApplications: []
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
        storageUri: ''
      }
    }
    extensionsTimeBudget: 'PT1H30M'
    hardwareProfile: {
      vmSize: 'Standard_B1ls'
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: 'network-230630033559397415'
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
  name: 'subnet-230630033559397415'
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.2.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: resourceName
  location: location
  properties: {
    description: ''
    destinations: {
      azureMonitorMetrics: {
        name: 'test-destination-metrics'
      }
    }
    dataFlows: [
      {
        destinations: [
          'test-destination-metrics'
        ]
        streams: [
          'Microsoft-InsightsMetrics'
        ]
      }
    ]
  }
}

resource dataCollectionRuleAssociation 'Microsoft.Insights/dataCollectionRuleAssociations@2022-06-01' = {
  name: resourceName
  scope: virtualMachine
  properties: {
    dataCollectionRuleId: dataCollectionRule.id
    description: ''
  }
}
