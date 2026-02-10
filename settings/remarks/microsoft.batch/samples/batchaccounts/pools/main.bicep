param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource batchAccount 'Microsoft.Batch/batchAccounts@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    encryption: {
      keySource: 'Microsoft.Batch'
    }
    poolAllocationMode: 'BatchService'
    publicNetworkAccess: 'Enabled'
  }
}

resource pool 'Microsoft.Batch/batchAccounts/pools@2022-10-01' = {
  name: resourceName
  parent: batchAccount
  properties: {
    certificates: null
    deploymentConfiguration: {
      virtualMachineConfiguration: {
        imageReference: {
          offer: 'UbuntuServer'
          publisher: 'Canonical'
          sku: '18.04-lts'
          version: 'latest'
        }
        nodeAgentSkuId: 'batch.node.ubuntu 18.04'
        osDisk: {
          ephemeralOSDiskSettings: {
            placement: ''
          }
        }
      }
    }
    taskSlotsPerNode: 1
    displayName: ''
    interNodeCommunication: 'Enabled'
    metadata: []
    scaleSettings: {
      fixedScale: {
        resizeTimeout: 'PT15M'
        targetDedicatedNodes: 1
        targetLowPriorityNodes: 0
        nodeDeallocationOption: ''
      }
    }
    vmSize: 'STANDARD_A1'
  }
}
