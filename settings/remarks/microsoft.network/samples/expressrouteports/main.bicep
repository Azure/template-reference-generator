param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource expressRoutePort 'Microsoft.Network/ExpressRoutePorts@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    bandwidthInGbps: 10
    billingType: 'MeteredData'
    encapsulation: 'Dot1Q'
    peeringLocation: 'Airtel-Chennai2-CLS'
  }
  tags: {
    ENV: 'Test'
  }
}
