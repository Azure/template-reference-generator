param resourceName string = 'acctest0001'
param location string = 'eastus'

resource mobileNetwork 'Microsoft.MobileNetwork/mobileNetworks@2022-11-01' = {
  name: resourceName
  location: location
  properties: {
    publicLandMobileNetworkIdentifier: {
      mnc: '01'
      mcc: '001'
    }
  }
}

resource dataNetwork 'Microsoft.MobileNetwork/mobileNetworks/dataNetworks@2022-11-01' = {
  name: resourceName
  location: location
  parent: mobileNetwork
  properties: {}
}
