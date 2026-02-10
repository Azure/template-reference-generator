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
          id: networkInterface.id
          properties: {
            primary: false
          }
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
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        name: 'myosdisk1'
        writeAcceleratorEnabled: false
      }
      imageReference: {
        version: 'latest'
        offer: 'UbuntuServer'
        publisher: 'Canonical'
        sku: '16.04-LTS'
      }
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

resource workloadImpact 'Microsoft.Impact/workloadImpacts@2023-12-01-preview' = {
  name: resourceName
  properties: {
    errorDetails: {
      errorCode: 'code'
      errorMessage: 'errorMessage'
    }
    impactCategory: 'Resource.Availability'
    impactedResourceId: virtualMachine.id
    performance: [
      {
        expectedValueRange: {
          max: 5
          min: 1
        }
        metricName: 'example'
        unit: 'ByteSeconds'
        actual: 2
        expected: 2
      }
    ]
    startDateTime: '2024-12-03T01:15:00Z'
    workload: {
      context: 'context'
      toolset: 'Ansible'
    }
    additionalProperties: {
      NodeId: 'node-123'
      Manufacturer: 'ManufacturerName'
      ModelNumber: 'Model123'
      PhysicalHostName: 'host123'
      SerialNumber: 'SN123456'
      VmUniqueId: 'vm-unique-id'
      CollectTelemetry: true
      Location: 'DataCenter1'
      LogUrl: 'http://example.com/log'
    }
    armCorrelationIds: [
      'id1'
      'id2'
    ]
    clientIncidentDetails: {
      clientIncidentId: 'id'
      clientIncidentSource: 'AzureDevops'
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
    impactDescription: 'impact description'
    impactGroupId: 'impact groupid'
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'testconfiguration1'
        properties: {
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
        }
      }
    ]
    enableAcceleratedNetworking: false
  }
}
