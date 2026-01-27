param resourceName string = 'acctest0001'
param location string = 'westus'

resource lab 'Microsoft.DevTestLab/labs@2018-09-15' = {
  name: resourceName
  location: location
}

// The policy set is a singleton named 'default' under the lab
resource policySet 'Microsoft.DevTestLab/labs/policySets@2018-09-15' existing = {
  parent: lab
  name: 'default'
}

resource policy 'Microsoft.DevTestLab/labs/policySets/policies@2018-09-15' = {
  parent: policySet
  name: 'LabVmCount'
  properties: {
    description: ''
    evaluatorType: 'MaxValuePolicy'
    factData: ''
    factName: 'LabVmCount'
    threshold: '999'
  }
}
