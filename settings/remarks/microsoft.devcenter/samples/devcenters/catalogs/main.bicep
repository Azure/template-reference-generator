param resourceName string = 'acctest0001'
param location string = 'westus'

resource devCenter 'Microsoft.DevCenter/devCenters@2025-02-01' = {
  name: '${substring(resourceName, 0, 22)}-dc'
  location: location
  properties: {}
}

resource catalog 'Microsoft.DevCenter/devCenters/catalogs@2025-02-01' = {
  name: '${substring(resourceName, 0, 17)}-catalog'
  parent: devCenter
  properties: {
    adoGit: {
      path: '/template'
      secretIdentifier: 'https://amlim-kv.vault.azure.net/secrets/ado/6279752c2bdd4a38a3e79d958cc36a75'
      uri: 'https://amlim@dev.azure.com/amlim/testCatalog/_git/testCatalog'
      branch: 'main'
    }
  }
}
