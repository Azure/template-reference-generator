param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: 'network-230630033559397415'
  location: location
  properties: {
    subnets: []
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
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
    description: ''
    destinations: {
      azureMonitorMetrics: {
        name: 'test-destination-metrics'
      }
    }
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: 'machine-230630033559397415'
  location: location
  properties: {
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
    osProfile: {
      adminPassword: adminPassword
      adminUsername: 'adminuser'
      allowExtensionOperations: true
      computerName: 'machine-230630033559397415'
      linuxConfiguration: {
        provisionVMAgent: true
        ssh: {
          publicKeys: []
        }
        disablePasswordAuthentication: false
        patchSettings: {
          assessmentMode: 'ImageDefault'
          patchMode: 'ImageDefault'
        }
      }
      secrets: []
    }
    additionalCapabilities: {}
    applicationProfile: {
      galleryApplications: []
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
    priority: 'Regular'
    storageProfile: {
      dataDisks: []
      imageReference: {
        offer: 'UbuntuServer'
        publisher: 'Canonical'
        sku: '16.04-LTS'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        writeAcceleratorEnabled: false
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
    }
  }
}

resource dataCollectionRuleAssociation 'Microsoft.Insights/dataCollectionRuleAssociations@2022-06-01' = {
  name: resourceName
  scope: virtualMachine
  properties: {
    description: ''
    dataCollectionRuleId: dataCollectionRule.id
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: 'nic-230630033559397415'
  location: location
  properties: {
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        properties: {
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
        }
        name: 'internal'
      }
    ]
  }
}
