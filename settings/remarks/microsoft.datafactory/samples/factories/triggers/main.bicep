param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource factory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    repoConfiguration: null
  }
}

resource pipeline 'Microsoft.DataFactory/factories/pipelines@2018-06-01' = {
  parent: factory
  name: resourceName
  properties: {
    annotations: []
    description: ''
    parameters: {
      test: {
        defaultValue: 'testparameter'
        type: 'String'
      }
    }
    variables: {}
  }
}

resource trigger 'Microsoft.DataFactory/factories/triggers@2018-06-01' = {
  parent: factory
  name: resourceName
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
