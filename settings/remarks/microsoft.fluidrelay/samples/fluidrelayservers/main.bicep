param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource fluidRelayServer 'Microsoft.FluidRelay/fluidRelayServers@2022-05-26' = {
  name: resourceName
  location: location
  properties: {}
  tags: {
    foo: 'bar'
  }
}
