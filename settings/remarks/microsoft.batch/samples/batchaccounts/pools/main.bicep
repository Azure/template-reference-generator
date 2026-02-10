param location string = 'westeurope'
param resourceName string = 'acctest0001'

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
    displayName: ''
    interNodeCommunication: 'Enabled'
    scaleSettings: {
      fixedScale: {
        targetLowPriorityNodes: 0
        nodeDeallocationOption: ''
        resizeTimeout: 'PT15M'
        targetDedicatedNodes: 1
      }
    }
    taskSlotsPerNode: 1
    metadata: []
    vmSize: 'STANDARD_A1'
    certificates: null
    deploymentConfiguration: {
      virtualMachineConfiguration: {
        osDisk: {
          ephemeralOSDiskSettings: {
            placement: ''
          }
        }
        imageReference: {
          offer: 'UbuntuServer'
          publisher: 'Canonical'
          sku: '18.04-lts'
          version: 'latest'
        }
        nodeAgentSkuId: 'batch.node.ubuntu 18.04'
      }
    }
  }
}
