param resourceName string = 'acctest0001'
param location string = 'eastus'

resource simGroup 'Microsoft.MobileNetwork/simGroups@2022-11-01' = {
  name: resourceName
  location: location
  properties: {
    mobileNetwork: {
      id: mobileNetwork.id
    }
  }
}

resource mobileNetwork 'Microsoft.MobileNetwork/mobileNetworks@2022-11-01' = {
  name: resourceName
  location: location
  properties: {
    publicLandMobileNetworkIdentifier: {
      mcc: '001'
      mnc: '01'
    }
  }
}
