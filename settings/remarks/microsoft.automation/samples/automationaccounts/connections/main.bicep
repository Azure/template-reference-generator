param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The Application ID of the Azure service principal for the automation account connection')
param servicePrincipalApplicationId string

resource automationAccount 'Microsoft.Automation/automationAccounts@2021-06-22' = {
  name: resourceName
  location: location
  properties: {
    encryption: {
      keySource: 'Microsoft.Automation'
    }
    publicNetworkAccess: true
    sku: {
      name: 'Basic'
    }
  }
}

resource connection 'Microsoft.Automation/automationAccounts/connections@2020-01-13-preview' = {
  name: resourceName
  parent: automationAccount
  properties: {
    connectionType: {
      name: 'AzureServicePrincipal'
    }
    description: ''
    fieldDefinitionValues: {
      CertificateThumbprint: '''AEB97B81A68E8988850972916A8B8B6CD8F39813
'''
      SubscriptionId: subscription().subscriptionId
      TenantId: tenant().tenantId
      ApplicationId: servicePrincipalApplicationId
    }
  }
}
