param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The PEM-encoded certificate for the confidential ledger administrator')
param ledgerCertificate string

resource ledger 'Microsoft.ConfidentialLedger/ledgers@2022-05-13' = {
  name: resourceName
  location: location
  properties: {
    aadBasedSecurityPrincipals: [
      {
        principalId: deployer().objectId
        tenantId: tenant().tenantId
        ledgerRoleName: 'Administrator'
      }
    ]
    certBasedSecurityPrincipals: [
      {
        cert: ledgerCertificate
        ledgerRoleName: 'Administrator'
      }
    ]
    ledgerType: 'Private'
  }
}
