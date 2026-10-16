@description('The name of the parameter group')
param parameterGroupName string = 'production-parameters'

resource horizonDbResource 'Microsoft.HorizonDb/parameterGroups@2026-10-01-preview' = {
  name: parameterGroupName
  location: 'eastus2'
  tags: {
    environment: 'production'
  }
  properties: {
    postgreSqlVersion: '17'
    parameters: [
      {
        name: 'application_name'
        value: 'horizondb-production'
      }
      {
        name: 'autovacuum'
        value: 'off'
      }
      {
        name: 'wal_receiver_timeout'
        value: '45000'
      }
      {
        name: 'work_mem'
        value: '8192'
      }
      {
        name: 'xmlbinary'
        value: 'base64'
      }
    ]
    description: 'Parameters for production transactional workloads'
  }
}
