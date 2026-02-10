param resourceName string = 'acctest0001'
param location string = 'eastus'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: '${resourceName}-vnet'
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
  name: '${resourceName}-subnet'
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

resource containerGroupProfile 'Microsoft.ContainerInstance/containerGroupProfiles@2024-05-01-preview' = {
  name: '${resourceName}-contianerGroup'
  location: location
  properties: {
    sku: 'Standard'
    containers: [
      {
        name: 'mycontainergroupprofile'
        properties: {
          ports: [
            {
              port: 8000
            }
          ]
          resources: {
            requests: {
              cpu: 1
              memoryInGB: any('1.5')
            }
          }
          command: []
          environmentVariables: []
          image: 'mcr.microsoft.com/azuredocs/aci-helloworld:latest'
        }
      }
    ]
    imageRegistryCredentials: []
    ipAddress: {
      ports: [
        {
          port: 8000
          protocol: 'TCP'
        }
      ]
      type: 'Public'
    }
    osType: 'Linux'
  }
}

resource standbyContainerGroupPool 'Microsoft.StandbyPool/standbyContainerGroupPools@2025-03-01' = {
  name: '${resourceName}-CGPool'
  properties: {
    zones: [
      '1'
      '2'
      '3'
    ]
    containerGroupProperties: {
      containerGroupProfile: {
        id: containerGroupProfile.id
        revision: 1
      }
      subnetIds: [
        {}
      ]
    }
    elasticityProfile: {
      refillPolicy: 'always'
      maxReadyCapacity: 5
    }
  }
}
