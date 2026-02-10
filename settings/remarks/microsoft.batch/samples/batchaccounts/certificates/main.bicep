param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The base64-encoded certificate data')
param certificateData string
@description('The thumbprint of the certificate')
param certificateThumbprint string

resource batchAccount 'Microsoft.Batch/batchAccounts@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    encryption: {
      keySource: 'Microsoft.Batch'
    }
    poolAllocationMode: 'BatchService'
    publicNetworkAccess: 'Enabled'
  }
}

resource certificate 'Microsoft.Batch/batchAccounts/certificates@2022-10-01' = {
  name: 'SHA1-${certificateThumbprint}'
  parent: batchAccount
  properties: {
    thumbprint: '${certificateThumbprint}'
    thumbprintAlgorithm: 'sha1'
    data: '${certificateData}'
    format: 'Cer'
  }
}
