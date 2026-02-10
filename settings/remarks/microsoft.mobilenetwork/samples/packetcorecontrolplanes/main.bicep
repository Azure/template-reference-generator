param resourceName string = 'acctest0001'
param location string = 'eastus'

resource packetCoreControlPlane 'Microsoft.MobileNetwork/packetCoreControlPlanes@2022-11-01' = {
  name: resourceName
  location: location
  properties: {
    platform: {
      azureStackEdgeDevice: {
        id: dataBoxEdgeDevice.id
      }
      type: 'AKS-HCI'
    }
    sites: [
      {}
    ]
    sku: 'G0'
    ueMtu: 1440
    controlPlaneAccessInterface: {}
    localDiagnosticsAccess: {
      authenticationType: 'AAD'
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

resource site 'Microsoft.MobileNetwork/mobileNetworks/sites@2022-11-01' = {
  name: resourceName
  location: location
  parent: mobileNetwork
  properties: {}
}

resource dataBoxEdgeDevice 'Microsoft.DataBoxEdge/dataBoxEdgeDevices@2022-03-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'EdgeP_Base'
    tier: 'Standard'
  }
}
