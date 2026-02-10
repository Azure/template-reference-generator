param resourceName string = 'acctest0001'
param location string = 'eastus'

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

resource service 'Microsoft.MobileNetwork/mobileNetworks/services@2022-11-01' = {
  name: resourceName
  location: location
  parent: mobileNetwork
  properties: {
    pccRules: [
      {
        rulePrecedence: 1
        serviceDataFlowTemplates: [
          {
            remoteIpList: [
              '10.3.4.0/24'
            ]
            templateName: 'IP-to-server'
            direction: 'Uplink'
            ports: []
            protocol: [
              'ip'
            ]
          }
        ]
        trafficControl: 'Enabled'
        ruleName: 'default-rule'
      }
    ]
    servicePrecedence: 0
  }
}
