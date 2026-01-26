param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource devCenter 'Microsoft.DevCenter/devcenters@2023-04-01' = {
  name: resourceName
  location: location
  identity: {
    type: 'SystemAssigned'
    userAssignedIdentities: null
  }
}

resource devBoxDefinition 'Microsoft.DevCenter/devcenters/devboxdefinitions@2024-10-01-preview' = {
  parent: devCenter
  name: resourceName
  location: location
  properties: {
    hibernateSupport: 'Enabled'
    imageReference: {
      id: '${devCenter.id}/galleries/default/images/microsoftvisualstudio_visualstudioplustools_vs-2022-ent-general-win10-m365-gen2'
    }
    sku: {
      name: 'general_i_8c32gb256ssd_v2'
    }
  }
}
