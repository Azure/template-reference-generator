param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource automation 'Microsoft.Security/automations@2019-01-01-preview' = {
  name: 'ExportToWorkspace'
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    isEnabled: true
    scopes: [
      {
        description: 'Security Export for the subscription'
        scopePath: resourceGroup().id
      }
    ]
    sources: [
      {
        eventSource: 'Assessments'
        ruleSets: [
          {
            rules: [
              {
                propertyJPath: 'type'
                propertyType: 'String'
                expectedValue: 'Microsoft.Security/assessments'
                operator: 'Contains'
              }
            ]
          }
        ]
      }
      {
        eventSource: 'AssessmentsSnapshot'
        ruleSets: [
          {
            rules: [
              {
                propertyJPath: 'type'
                propertyType: 'String'
                expectedValue: 'Microsoft.Security/assessments'
                operator: 'Contains'
              }
            ]
          }
        ]
      }
      {
        eventSource: 'SubAssessments'
      }
      {
        eventSource: 'SubAssessmentsSnapshot'
      }
      {
        eventSource: 'Alerts'
        ruleSets: [
          {
            rules: [
              {
                propertyJPath: 'Severity'
                propertyType: 'String'
                expectedValue: 'low'
                operator: 'Equals'
              }
            ]
          }
          {
            rules: [
              {
                propertyJPath: 'Severity'
                propertyType: 'String'
                expectedValue: 'medium'
                operator: 'Equals'
              }
            ]
          }
          {
            rules: [
              {
                propertyJPath: 'Severity'
                propertyType: 'String'
                expectedValue: 'high'
                operator: 'Equals'
              }
            ]
          }
          {
            rules: [
              {
                propertyJPath: 'Severity'
                propertyType: 'String'
                expectedValue: 'informational'
                operator: 'Equals'
              }
            ]
          }
        ]
      }
      {
        eventSource: 'SecureScores'
      }
      {
        eventSource: 'SecureScoresSnapshot'
      }
      {
        eventSource: 'SecureScoreControls'
      }
      {
        eventSource: 'SecureScoreControlsSnapshot'
      }
      {
        eventSource: 'RegulatoryComplianceAssessment'
      }
      {
        eventSource: 'RegulatoryComplianceAssessmentSnapshot'
      }
    ]
    actions: [
      {
        workspaceResourceId: workspace.id
        actionType: 'Workspace'
      }
    ]
  }
}

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    features: {
      disableLocalAuth: false
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
  }
}
