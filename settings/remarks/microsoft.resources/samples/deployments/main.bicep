param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource deployment 'Microsoft.Resources/deployments@2020-06-01' = {
  name: resourceName
  properties: {
    mode: 'Complete'
    template: {
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
          type: 'Microsoft.Network/publicIPAddresses'
          apiVersion: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          location: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          name: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          properties: {
            publicIPAllocationMethod: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
            dnsSettings: {
              domainNameLabel: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
            }
          }
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
      '$schema': 'https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#'
      contentVersion: '1.0.0.0'
      parameters: {
        storageAccountType: {
          defaultValue: 'Standard_LRS'
          metadata: {
            description: 'Storage Account type'
          }
          type: 'string'
          allowedValues: [
            'Standard_LRS'
            'Standard_GRS'
            'Standard_ZRS'
          ]
        }
      }
    }
  }
}
