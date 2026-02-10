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

resource service 'Microsoft.MobileNetwork/mobileNetworks/services@2022-11-01' = {
  name: resourceName
  location: location
  parent: mobileNetwork
  properties: {
    pccRules: [
      {
        ruleName: 'default-rule'
        rulePrecedence: 1
        serviceDataFlowTemplates: [
          {
            templateName: 'IP-to-server'
            direction: 'Uplink'
            ports: []
            protocol: [
              'ip'
            ]
            remoteIpList: [
              '10.3.4.0/24'
            ]
          }
        ]
        trafficControl: 'Enabled'
      }
    ]
    servicePrecedence: 0
  }
}

resource simPolicy 'Microsoft.MobileNetwork/mobileNetworks/simPolicies@2022-11-01' = {
  name: resourceName
  location: location
  parent: mobileNetwork
  properties: {
    defaultSlice: {}
    registrationTimer: 3240
    sliceConfigurations: [
      {
        dataNetworkConfigurations: [
          {
            '5qi': 9
            additionalAllowedSessionTypes: null
            allocationAndRetentionPriorityLevel: 9
            allowedServices: [
              {
                id: service.id
              }
            ]
            dataNetwork: {
              id: dataNetwork.id
            }
            preemptionCapability: 'NotPreempt'
            sessionAmbr: {
              downlink: '1 Gbps'
              uplink: '500 Mbps'
            }
            defaultSessionType: 'IPv4'
            maximumNumberOfBufferedPackets: 10
            preemptionVulnerability: 'Preemptable'
          }
        ]
        defaultDataNetwork: {
          id: dataNetwork.id
        }
        slice: {}
      }
    ]
    ueAmbr: {
      downlink: '1 Gbps'
      uplink: '500 Mbps'
    }
  }
  tags: {
    key: 'value'
  }
}

resource slice 'Microsoft.MobileNetwork/mobileNetworks/slices@2022-11-01' = {
  name: resourceName
  location: location
  parent: mobileNetwork
  properties: {
    snssai: {
      sst: 1
    }
  }
}
