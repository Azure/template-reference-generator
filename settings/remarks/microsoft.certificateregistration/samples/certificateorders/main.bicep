param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource certificateOrder 'Microsoft.CertificateRegistration/certificateOrders@2021-02-01' = {
  name: resourceName
  location: 'global'
  properties: {
    validityInYears: 1
    autoRenew: true
    distinguishedName: 'CN=example.com'
    keySize: 2048
    productType: 'StandardDomainValidatedSsl'
  }
}
