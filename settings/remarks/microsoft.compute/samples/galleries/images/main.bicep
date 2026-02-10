param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource gallery 'Microsoft.Compute/galleries@2022-03-03' = {
  name: resourceName
  location: location
  properties: {
    description: ''
  }
}

resource image 'Microsoft.Compute/galleries/images@2022-03-03' = {
  name: resourceName
  location: location
  parent: gallery
  properties: {
    architecture: 'x64'
    disallowed: {
      diskTypes: []
    }
    features: null
    hyperVGeneration: 'V1'
    identifier: {
      offer: 'AccTesOffer230630032848825313'
      publisher: 'AccTesPublisher230630032848825313'
      sku: 'AccTesSku230630032848825313'
    }
    releaseNoteUri: ''
    description: ''
    osState: 'Generalized'
    osType: 'Linux'
    privacyStatementUri: ''
    recommended: {
      memory: {}
      vCPUs: {}
    }
  }
}
