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
      domainFqdn: 'testdomain.com'
      ouPath: ''
      sqlServiceAccount: ''
      storageAccountPrimaryKey: ''
      clusterBootstrapAccount: ''
      clusterSubnetType: 'SingleSubnet'
      storageAccountUrl: ''
    }
  }
}
