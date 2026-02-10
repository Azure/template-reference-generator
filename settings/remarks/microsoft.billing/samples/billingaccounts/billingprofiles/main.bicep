targetScope = 'tenant'

param resourceName string = 'acctest0001'
@description('Specify Billing Account Id for Billing Profile')
param billingAccountId string
@description('Specify Payment Method Id (For example: Credit Card and etc)')
param paymentMethodId string
@description('Specify Payment SCA Id for Payment Method Validation')
param paymentScaId string

resource billingProfile 'Microsoft.Billing/billingAccounts/billingProfiles@2024-04-01' = {
  name: resourceName
  properties: {
    shipTo: {
      country: 'US'
      isValidAddress: true
      postalCode: '12345-1234'
      region: 'WA'
      addressLine1: 'TestWay'
      city: 'Redmond'
      companyName: 'TestCompany'
    }
    billTo: {
      country: 'US'
      isValidAddress: true
      postalCode: '12345-1234'
      region: 'WA'
      addressLine1: 'TestWay'
      city: 'Redmond'
      companyName: 'TestCompany'
    }
    displayName: '${resourceName}'
    enabledAzurePlans: [
      {
        skuId: '0001'
      }
    ]
  }
}
