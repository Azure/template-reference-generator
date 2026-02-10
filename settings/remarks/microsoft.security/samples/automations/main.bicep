param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource automation 'Microsoft.Security/automations@2019-01-01-preview' = {
  name: 'ExportToWorkspace'
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    isEnabled: true
    scopes: [
      {
        description: 'Security Export for the subscription'
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
                propertyType: 'String'
                expectedValue: 'low'
                operator: 'Equals'
                propertyJPath: 'Severity'
              }
            ]
          }
          {
            rules: [
              {
                propertyType: 'String'
                expectedValue: 'medium'
                operator: 'Equals'
                propertyJPath: 'Severity'
              }
            ]
          }
          {
            rules: [
              {
                operator: 'Equals'
                propertyJPath: 'Severity'
                propertyType: 'String'
                expectedValue: 'high'
              }
            ]
          }
          {
            rules: [
              {
                operator: 'Equals'
                propertyJPath: 'Severity'
                propertyType: 'String'
                expectedValue: 'informational'
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
