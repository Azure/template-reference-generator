param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource deployment 'Microsoft.Resources/deployments@2020-06-01' = {
  name: resourceName
  properties: {
    mode: 'Complete'
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
          apiVersion: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          location: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          name: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          properties: {
            accountType: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          }
          type: 'Microsoft.Storage/storageAccounts'
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
        apiVersion: '2015-06-15'
        dnsLabelPrefix: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        location: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        publicIPAddressName: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        publicIPAddressType: 'Dynamic'
        storageAccountName: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
      }
    }
  }
}
