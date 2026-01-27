param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource securityPartnerProvider 'Microsoft.Network/securityPartnerProviders@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    securityProviderName: 'ZScaler'
  }
}
