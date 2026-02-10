param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' existing = {
  name: resourceName
  parent: virtualNetwork
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
    subnets: [
      {
        name: 'Default'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
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
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
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
        name: 'allow_tds_inbound'
        properties: {
          description: 'Allow access to data'
          destinationAddressPrefix: '*'
          destinationPortRange: '1433'
          direction: 'Inbound'
          priority: 1000
          protocol: 'TCP'
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          access: 'Allow'
        }
      }
      {
        name: 'allow_redirect_inbound'
        properties: {
          destinationAddressPrefix: '*'
          priority: 1100
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '11000-11999'
          direction: 'Inbound'
          sourceAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          description: 'Allow inbound redirect traffic to Managed Instance inside the virtual network'
        }
      }
      {
        name: 'allow_geodr_inbound'
        properties: {
          description: 'Allow inbound geodr traffic inside the virtual network'
          destinationAddressPrefix: '*'
          destinationPortRange: '5022'
          protocol: 'Tcp'
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          access: 'Allow'
          direction: 'Inbound'
          priority: 1200
        }
      }
      {
        name: 'deny_all_inbound'
        properties: {
          protocol: '*'
          access: 'Deny'
          description: 'Deny all other inbound traffic'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '*'
          direction: 'Inbound'
          priority: 4096
        }
      }
      {
        name: 'allow_linkedserver_outbound'
        properties: {
          description: 'Allow outbound linkedserver traffic inside the virtual network'
          destinationPortRange: '1433'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: 'VirtualNetwork'
          direction: 'Outbound'
          priority: 1000
          protocol: 'Tcp'
          sourcePortRange: '*'
          access: 'Allow'
        }
      }
      {
        name: 'allow_redirect_outbound'
        properties: {
          access: 'Allow'
          description: 'Allow outbound redirect traffic to Managed Instance inside the virtual network'
          direction: 'Outbound'
          priority: 1100
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: 'VirtualNetwork'
          destinationPortRange: '11000-11999'
          protocol: 'Tcp'
        }
      }
      {
        name: 'allow_geodr_outbound'
        properties: {
          description: 'Allow outbound geodr traffic inside the virtual network'
          destinationPortRange: '5022'
          priority: 1200
          sourceAddressPrefix: '*'
          access: 'Allow'
          destinationAddressPrefix: 'VirtualNetwork'
          direction: 'Outbound'
          protocol: 'Tcp'
          sourcePortRange: '*'
        }
      }
      {
        properties: {
          destinationPortRange: '*'
          direction: 'Outbound'
          protocol: '*'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          access: 'Deny'
          description: 'Deny all other outbound traffic'
          destinationAddressPrefix: '*'
          priority: 4096
        }
        name: 'deny_all_outbound'
      }
    ]
  }
}
