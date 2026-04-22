param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource expressRoutePort 'Microsoft.Network/ExpressRoutePorts@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    encapsulation: 'Dot1Q'
    peeringLocation: 'Airtel-Chennai2-CLS'
    bandwidthInGbps: 10
    billingType: 'MeteredData'
  }
  tags: {
    ENV: 'Test'
  }
}
