param location string = 'westus'
param resourceName string = 'acctest0001'

resource attestationProvider 'Microsoft.Attestation/attestationProviders@2020-10-01' = {
  name: resourceName
  location: location
  properties: {}
}
