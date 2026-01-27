param resourceName string = 'acctest0001'
param location string = 'westus'

resource attestationProvider 'Microsoft.Attestation/attestationProviders@2020-10-01' = {
  name: resourceName
  location: location
  properties: {}
}
