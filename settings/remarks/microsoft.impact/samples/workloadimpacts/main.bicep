param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

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
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        properties: {
          subnet: {}
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
        }
        name: 'testconfiguration1'
      }
    ]
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: resourceName
  location: location
  properties: {
    osProfile: {
      adminUsername: 'testadmin'
      computerName: 'hostname230630032848831819'
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
      adminPassword: adminPassword
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

resource workloadImpact 'Microsoft.Impact/workloadImpacts@2023-12-01-preview' = {
  name: resourceName
  properties: {
    impactCategory: 'Resource.Availability'
    performance: [
      {
        actual: 2
        expected: 2
        expectedValueRange: {
          min: 1
          max: 5
        }
        metricName: 'example'
        unit: 'ByteSeconds'
      }
    ]
    startDateTime: '2024-12-03T01:15:00Z'
    workload: {
      context: 'context'
      toolset: 'Ansible'
    }
    additionalProperties: {
      Location: 'DataCenter1'
      LogUrl: 'http://example.com/log'
      ModelNumber: 'Model123'
      NodeId: 'node-123'
      PhysicalHostName: 'host123'
      SerialNumber: 'SN123456'
      CollectTelemetry: true
      Manufacturer: 'ManufacturerName'
      VmUniqueId: 'vm-unique-id'
    }
    armCorrelationIds: [
      'id1'
      'id2'
    ]
    clientIncidentDetails: {
      clientIncidentId: 'id'
      clientIncidentSource: 'AzureDevops'
    }
    connectivity: {
      port: 1443
      protocol: 'TCP'
      source: {
        azureResourceId: virtualMachine.id
      }
      target: {
        azureResourceId: virtualMachine.id
      }
    }
    errorDetails: {
      errorCode: 'code'
      errorMessage: 'errorMessage'
    }
    impactDescription: 'impact description'
    impactGroupId: 'impact groupid'
    impactedResourceId: virtualMachine.id
    confidenceLevel: 'High'
    endDateTime: '2024-12-04T01:15:00Z'
  }
}
