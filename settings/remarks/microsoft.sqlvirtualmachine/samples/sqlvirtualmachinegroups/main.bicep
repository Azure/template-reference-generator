param resourceName string = 'acctest0001'
param location string = 'westus'

resource sqlVirtualMachineGroup 'Microsoft.SqlVirtualMachine/sqlVirtualMachineGroups@2023-10-01' = {
  name: resourceName
  location: location
  properties: {
    sqlImageOffer: 'SQL2017-WS2016'
    sqlImageSku: 'Developer'
    wsfcDomainProfile: {
      clusterOperatorAccount: ''
      ouPath: ''
      sqlServiceAccount: ''
      storageAccountUrl: ''
      clusterBootstrapAccount: ''
      clusterSubnetType: 'SingleSubnet'
      domainFqdn: 'testdomain.com'
      storageAccountPrimaryKey: ''
    }
  }
}
