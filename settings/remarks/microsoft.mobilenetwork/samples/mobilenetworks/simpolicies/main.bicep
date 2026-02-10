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
            protocol: [
              'ip'
            ]
            remoteIpList: [
              '10.3.4.0/24'
            ]
            templateName: 'IP-to-server'
            direction: 'Uplink'
            ports: []
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
        defaultDataNetwork: {
          id: dataNetwork.id
        }
        slice: {}
        dataNetworkConfigurations: [
          {
            allocationAndRetentionPriorityLevel: 9
            dataNetwork: {
              id: dataNetwork.id
            }
            defaultSessionType: 'IPv4'
            preemptionVulnerability: 'Preemptable'
            allowedServices: [
              {
                id: service.id
              }
            ]
            maximumNumberOfBufferedPackets: 10
            preemptionCapability: 'NotPreempt'
            sessionAmbr: {
              uplink: '500 Mbps'
              downlink: '1 Gbps'
            }
            '5qi': 9
            additionalAllowedSessionTypes: null
          }
        ]
      }
    ]
    ueAmbr: {
      uplink: '500 Mbps'
      downlink: '1 Gbps'
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
