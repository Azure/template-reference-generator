param resourceName string = 'acctest0001'
param location string = 'westus'

resource codeSigningAccount 'Microsoft.CodeSigning/codeSigningAccounts@2024-09-30-preview' = {
  name: resourceName
  location: location
  properties: {
    sku: {
      name: 'Basic'
    }
  }
}
