param resourceName string = 'acctest0001'

resource certificateOrder 'Microsoft.CertificateRegistration/certificateOrders@2021-02-01' = {
  name: resourceName
  location: 'global'
  properties: {
    autoRenew: true
    distinguishedName: 'CN=example.com'
    keySize: 2048
    productType: 'StandardDomainValidatedSsl'
    validityInYears: 1
  }
}
