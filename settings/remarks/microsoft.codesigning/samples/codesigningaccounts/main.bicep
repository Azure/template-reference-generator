param location string = 'westus'
param resourceName string = 'acctest0001'

resource codeSigningAccount 'Microsoft.CodeSigning/codeSigningAccounts@2024-09-30-preview' = {
  name: resourceName
  location: location
  properties: {
    sku: {
      name: 'Basic'
    }
  }
}
