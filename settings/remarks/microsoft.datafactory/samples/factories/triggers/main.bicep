param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource factory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: resourceName
  location: location
  properties: {
    repoConfiguration: null
    publicNetworkAccess: 'Enabled'
  }
}

resource trigger 'Microsoft.DataFactory/factories/triggers@2018-06-01' = {
  name: resourceName
  parent: factory
  properties: {
    description: ''
    pipeline: {
      parameters: {}
      pipelineReference: {
        referenceName: pipeline.name
        type: 'PipelineReference'
      }
    }
    type: 'TumblingWindowTrigger'
    typeProperties: {
      frequency: 'Minute'
      interval: 15
      maxConcurrency: 50
      startTime: '2022-09-21T00:00:00Z'
    }
  }
}

resource pipeline 'Microsoft.DataFactory/factories/pipelines@2018-06-01' = {
  name: resourceName
  parent: factory
  properties: {
    parameters: {
      test: {
        type: 'String'
        defaultValue: 'testparameter'
      }
    }
    variables: {}
    annotations: []
    description: ''
  }
}
