targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'eastus'

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2022-06-01' = {
  name: resourceName
  scope: subscription()
  properties: {
    enforcementMode: 'Default'
    parameters: {
      listOfAllowedLocations: {
        value: [
          'West Europe'
          'West US 2'
          'East US 2'
        ]
      }
    }
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c'
    scope: subscription().id
    displayName: ''
  }
}

resource remediation 'Microsoft.PolicyInsights/remediations@2021-10-01' = {
  name: resourceName
  scope: subscription()
  properties: {
    policyAssignmentId: policyAssignment.id
    policyDefinitionReferenceId: ''
    resourceDiscoveryMode: 'ExistingNonCompliant'
    filters: {
      locations: []
    }
  }
}
