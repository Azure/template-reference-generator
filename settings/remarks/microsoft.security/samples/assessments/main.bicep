targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'westus'
@secure()
@description('The administrator password for the virtual machine scale set')
param adminPassword string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourceName
  location: location
}

resource assessmentMetadata 'Microsoft.Security/assessmentMetadata@2021-06-01' = {
  name: 'fdaaa62c-1d42-45ab-be2f-2af194dd1700'
  properties: {
    assessmentType: 'CustomerManaged'
    description: 'Test Description'
    displayName: 'Test Display Name'
    severity: 'Medium'
  }
}

resource pricing 'Microsoft.Security/pricings@2023-01-01' = {
  name: 'VirtualMachines'
  properties: {
    extensions: []
    pricingTier: 'Standard'
    subPlan: 'P2'
  }
}

module module1 'main-rg-module.bicep' = {
  name: 'deploy-rg-resources'
  scope: resourceGroup
  params: {
    resourceName: resourceName
    adminPassword: adminPassword
    location: location
  }
}
