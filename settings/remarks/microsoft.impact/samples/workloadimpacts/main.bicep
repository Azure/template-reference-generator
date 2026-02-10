param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

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
          properties: {
            primary: false
          }
          id: networkInterface.id
        }
      ]
    }
    osProfile: {
      adminPassword: adminPassword
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
        caching: 'ReadWrite'
        createOption: 'FromImage'
        name: 'myosdisk1'
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
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
  }
}

resource workloadImpact 'Microsoft.Impact/workloadImpacts@2023-12-01-preview' = {
  name: resourceName
  properties: {
    startDateTime: '2024-12-03T01:15:00Z'
    workload: {
      context: 'context'
      toolset: 'Ansible'
    }
    armCorrelationIds: [
      'id1'
      'id2'
    ]
    clientIncidentDetails: {
      clientIncidentId: 'id'
      clientIncidentSource: 'AzureDevops'
    }
    errorDetails: {
      errorCode: 'code'
      errorMessage: 'errorMessage'
    }
    impactCategory: 'Resource.Availability'
    impactDescription: 'impact description'
    impactedResourceId: virtualMachine.id
    performance: [
      {
        unit: 'ByteSeconds'
        actual: 2
        expected: 2
        expectedValueRange: {
          min: 1
          max: 5
        }
        metricName: 'example'
      }
    ]
    additionalProperties: {
      VmUniqueId: 'vm-unique-id'
      Location: 'DataCenter1'
      LogUrl: 'http://example.com/log'
      Manufacturer: 'ManufacturerName'
      PhysicalHostName: 'host123'
      CollectTelemetry: true
      ModelNumber: 'Model123'
      NodeId: 'node-123'
      SerialNumber: 'SN123456'
    }
    confidenceLevel: 'High'
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
    endDateTime: '2024-12-04T01:15:00Z'
    impactGroupId: 'impact groupid'
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
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

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'testconfiguration1'
        properties: {
          subnet: {}
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}
