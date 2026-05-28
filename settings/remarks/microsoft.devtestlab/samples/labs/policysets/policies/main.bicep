param location string = 'westus'
param resourceName string = 'acctest0001'

resource lab 'Microsoft.DevTestLab/labs@2018-09-15' = {
  name: resourceName
  location: location
}

resource policy 'Microsoft.DevTestLab/labs/policySets/policies@2018-09-15' = {
  name: 'LabVmCount'
  parent: policySet
  properties: {
    description: ''
    evaluatorType: 'MaxValuePolicy'
    factData: ''
    factName: 'LabVmCount'
    threshold: '999'
  }
}

resource policySet 'Microsoft.DevTestLab/labs/policySets@2018-09-15' existing = {
  name: 'default'
  parent: lab
}
