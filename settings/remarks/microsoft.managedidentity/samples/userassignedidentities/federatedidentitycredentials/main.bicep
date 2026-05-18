param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: resourceName
  location: location
}

resource federatedIdentityCredential 'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2022-01-31-preview' = {
  name: resourceName
  location: location
  parent: userAssignedIdentity
  properties: {
    audiences: [
      'foo'
    ]
    issuer: 'https://foo'
    subject: 'foo'
  }
}
