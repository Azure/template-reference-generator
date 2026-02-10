param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource deployment 'Microsoft.Resources/deployments@2020-06-01' = {
  name: resourceName
  properties: {
    template: {
      '$schema': 'https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      parameters: {
        storageAccountType: {
          allowedValues: [
            'Standard_LRS'
            'Standard_GRS'
            'Standard_ZRS'
          ]
          defaultValue: 'Standard_LRS'
          metadata: {
            description: 'Storage Account type'
          }
          type: 'string'
        }
      }
      resources: [
        {
          properties: {
            accountType: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          }
          type: 'Microsoft.Storage/storageAccounts'
          apiVersion: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          location: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          name: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        }
        {
          apiVersion: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          location: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          name: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          properties: {
            dnsSettings: {
              domainNameLabel: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
            }
            publicIPAllocationMethod: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          }
          type: 'Microsoft.Network/publicIPAddresses'
        }
      ]
      variables: {
        publicIPAddressName: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        publicIPAddressType: 'Dynamic'
        storageAccountName: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        apiVersion: '2015-06-15'
        dnsLabelPrefix: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        location: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
      }
    }
    mode: 'Complete'
  }
}
