param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The PEM-encoded certificate for the confidential ledger administrator')
param ledgerCertificate string

resource ledger 'Microsoft.ConfidentialLedger/ledgers@2022-05-13' = {
  name: resourceName
  location: location
  properties: {
    certBasedSecurityPrincipals: [
      {
        cert: ledgerCertificate
        ledgerRoleName: 'Administrator'
      }
    ]
    ledgerType: 'Private'
    aadBasedSecurityPrincipals: [
      {
        ledgerRoleName: 'Administrator'
        principalId: deployer().objectId
        tenantId: tenant().tenantId
      }
    ]
  }
}
