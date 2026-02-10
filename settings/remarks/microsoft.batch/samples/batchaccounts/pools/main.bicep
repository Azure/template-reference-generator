param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource batchAccount 'Microsoft.Batch/batchAccounts@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    encryption: {
      keySource: 'Microsoft.Batch'
    }
    poolAllocationMode: 'BatchService'
  }
}

resource pool 'Microsoft.Batch/batchAccounts/pools@2022-10-01' = {
  name: resourceName
  parent: batchAccount
  properties: {
    interNodeCommunication: 'Enabled'
    scaleSettings: {
      fixedScale: {
        targetDedicatedNodes: 1
        targetLowPriorityNodes: 0
        nodeDeallocationOption: ''
        resizeTimeout: 'PT15M'
      }
    }
    taskSlotsPerNode: 1
    vmSize: 'STANDARD_A1'
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
    displayName: ''
    metadata: []
  }
}
