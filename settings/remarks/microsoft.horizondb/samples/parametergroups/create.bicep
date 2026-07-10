@description('The name for the parameter group')
param parameterGroupName string
@description('The location for the parameter group')
param location string = 'eastus'
@description('The tags for the parameter group')
param tags object = {
  env: 'dev'
}
@description('The database parameters for the parameter group')
param parameters array = [
  {
    name: 'max_connections'
    value: '200'
  }
  {
    name: 'log_min_error_statement'
    value: 'error'
  }
  {
    name: 'shared_buffers'
    value: '2000'
  }
]
@description('The description of the parameter group')
param parameterGroupDescription string = 'Parameter group for high-throughput workloads'
@description('The PostgreSQL version for the parameter group')
param pgVersion int = 17
@description('Whether to apply changes immediately')
param applyImmediately bool = true
resource parameterGroup 'Microsoft.HorizonDB/parameterGroups@2026-01-20-preview' = {
  name: parameterGroupName
  location: location
  tags: tags
  properties: {
    parameters: parameters
    description: parameterGroupDescription
    pgVersion: pgVersion
    applyImmediately: applyImmediately
  }
}
