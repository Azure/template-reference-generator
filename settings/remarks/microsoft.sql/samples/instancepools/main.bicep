param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' existing = {
  name: resourceName
  parent: virtualNetwork
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
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          access: 'Allow'
          description: 'Allow access to data'
          destinationAddressPrefix: '*'
          priority: 1000
          destinationPortRange: '1433'
          direction: 'Inbound'
          protocol: 'TCP'
        }
      }
      {
        properties: {
          direction: 'Inbound'
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          access: 'Allow'
          description: 'Allow inbound redirect traffic to Managed Instance inside the virtual network'
          destinationAddressPrefix: '*'
          destinationPortRange: '11000-11999'
          priority: 1100
          protocol: 'Tcp'
        }
        name: 'allow_redirect_inbound'
      }
      {
        name: 'allow_geodr_inbound'
        properties: {
          destinationAddressPrefix: '*'
          description: 'Allow inbound geodr traffic inside the virtual network'
          destinationPortRange: '5022'
          direction: 'Inbound'
          priority: 1200
          protocol: 'Tcp'
          sourceAddressPrefix: 'VirtualNetwork'
          sourcePortRange: '*'
          access: 'Allow'
        }
      }
      {
        name: 'deny_all_inbound'
        properties: {
          destinationAddressPrefix: '*'
          destinationPortRange: '*'
          direction: 'Inbound'
          sourcePortRange: '*'
          description: 'Deny all other inbound traffic'
          priority: 4096
          protocol: '*'
          sourceAddressPrefix: '*'
          access: 'Deny'
        }
      }
      {
        name: 'allow_linkedserver_outbound'
        properties: {
          description: 'Allow outbound linkedserver traffic inside the virtual network'
          destinationAddressPrefix: 'VirtualNetwork'
          destinationPortRange: '1433'
          direction: 'Outbound'
          sourcePortRange: '*'
          priority: 1000
          protocol: 'Tcp'
          sourceAddressPrefix: '*'
          access: 'Allow'
        }
      }
      {
        name: 'allow_redirect_outbound'
        properties: {
          access: 'Allow'
          description: 'Allow outbound redirect traffic to Managed Instance inside the virtual network'
          destinationPortRange: '11000-11999'
          priority: 1100
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationAddressPrefix: 'VirtualNetwork'
          direction: 'Outbound'
          sourceAddressPrefix: '*'
        }
      }
      {
        name: 'allow_geodr_outbound'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          description: 'Allow outbound geodr traffic inside the virtual network'
          destinationAddressPrefix: 'VirtualNetwork'
          destinationPortRange: '5022'
          sourceAddressPrefix: '*'
          access: 'Allow'
          direction: 'Outbound'
          priority: 1200
        }
      }
      {
        name: 'deny_all_outbound'
        properties: {
          destinationPortRange: '*'
          sourcePortRange: '*'
          access: 'Deny'
          description: 'Deny all other outbound traffic'
          direction: 'Outbound'
          priority: 4096
          protocol: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
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
