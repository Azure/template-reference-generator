param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' existing = {
  name: resourceName
  parent: virtualNetwork
}

resource instancePool 'Microsoft.Sql/instancePools@2022-05-01-preview' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  sku: {
    family: 'Gen5'
    name: 'GP_Gen5'
    tier: 'GeneralPurpose'
  }
  properties: {
    licenseType: 'LicenseIncluded'
    subnetId: subnet.id
    vCores: 8
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2023-04-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    securityRules: [
      {
        properties: {
          sourcePortRange: '*'
          access: 'Allow'
          description: 'Allow access to data'
          destinationAddressPrefix: '*'
          destinationPortRange: '1433'
          priority: 1000
          direction: 'Inbound'
          protocol: 'TCP'
          sourceAddressPrefix: 'VirtualNetwork'
        }
        name: 'allow_tds_inbound'
      }
      {
        name: 'allow_redirect_inbound'
        properties: {
          description: 'Allow inbound redirect traffic to Managed Instance inside the virtual network'
          destinationAddressPrefix: '*'
          destinationPortRange: '11000-11999'
          protocol: 'Tcp'
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          access: 'Allow'
          direction: 'Inbound'
          priority: 1100
        }
      }
      {
        name: 'allow_geodr_inbound'
        properties: {
          description: 'Allow inbound geodr traffic inside the virtual network'
          priority: 1200
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '5022'
          direction: 'Inbound'
          protocol: 'Tcp'
          access: 'Allow'
        }
      }
      {
        name: 'deny_all_inbound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          access: 'Deny'
          description: 'Deny all other inbound traffic'
          destinationAddressPrefix: '*'
          priority: 4096
        }
      }
      {
        name: 'allow_linkedserver_outbound'
        properties: {
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          description: 'Allow outbound linkedserver traffic inside the virtual network'
          destinationPortRange: '1433'
          direction: 'Outbound'
          priority: 1000
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
        }
      }
      {
        name: 'allow_redirect_outbound'
        properties: {
          destinationPortRange: '11000-11999'
          direction: 'Outbound'
          protocol: 'Tcp'
          sourcePortRange: '*'
          access: 'Allow'
          destinationAddressPrefix: 'VirtualNetwork'
          priority: 1100
          sourceAddressPrefix: '*'
          description: 'Allow outbound redirect traffic to Managed Instance inside the virtual network'
        }
      }
      {
        name: 'allow_geodr_outbound'
        properties: {
          destinationAddressPrefix: 'VirtualNetwork'
          protocol: 'Tcp'
          access: 'Allow'
          description: 'Allow outbound geodr traffic inside the virtual network'
          destinationPortRange: '5022'
          direction: 'Outbound'
          priority: 1200
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
        }
      }
      {
        properties: {
          destinationPortRange: '*'
          protocol: '*'
          access: 'Deny'
          description: 'Deny all other outbound traffic'
          direction: 'Outbound'
          priority: 4096
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
        }
        name: 'deny_all_outbound'
      }
    ]
  }
}

resource routeTable 'Microsoft.Network/routeTables@2023-04-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    disableBgpRoutePropagation: false
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
        name: 'Default'
      }
      {
        name: resourceName
        properties: {
          addressPrefix: '10.0.1.0/24'
          networkSecurityGroup: {
            id: networkSecurityGroup.id
          }
          routeTable: {
            id: routeTable.id
          }
          delegations: [
            {
              name: 'miDelegation'
              properties: {
                serviceName: 'Microsoft.Sql/managedInstances'
              }
            }
          ]
        }
      }
    ]
  }
}
