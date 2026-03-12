param resourceName string = 'acctest0001'
param location string = 'westus'

resource lab 'Microsoft.DevTestLab/labs@2018-09-15' = {
  name: resourceName
  location: location
}

resource policy 'Microsoft.DevTestLab/labs/policySets/policies@2018-09-15' = {
  name: 'policySets/default/LabVmCount'
  properties: {
    description: ''
    evaluatorType: 'MaxValuePolicy'
    factData: ''
    factName: 'LabVmCount'
    threshold: '999'
  }
}
