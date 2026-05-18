param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

resource workloadImpact 'Microsoft.Impact/workloadImpacts@2023-12-01-preview' = {
  name: resourceName
  properties: {
    additionalProperties: {
      CollectTelemetry: true
      Location: 'DataCenter1'
      LogUrl: 'http://example.com/log'
      Manufacturer: 'ManufacturerName'
      ModelNumber: 'Model123'
      NodeId: 'node-123'
      PhysicalHostName: 'host123'
      SerialNumber: 'SN123456'
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
    errorDetails: {
      errorCode: 'code'
      errorMessage: 'errorMessage'
    }
    impactCategory: 'Resource.Availability'
    impactDescription: 'impact description'
    impactGroupId: 'impact groupid'
    impactedResourceId: virtualMachine.id
    performance: [
      {
        actual: 2
        expected: 2
        expectedValueRange: {
          max: 5
          min: 1
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
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'testconfiguration1'
        properties: {
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnet.id
          }
        }
      }
    ]
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
