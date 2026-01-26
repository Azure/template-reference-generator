param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The password for the automation account hybrid runbook worker')
param automationWorkerPassword string
@secure()
@description('The administrator password for the virtual machine')
param vmAdminPassword string

resource automationAccount 'Microsoft.Automation/automationAccounts@2021-06-22' = {
  name: resourceName
  location: location
  properties: {
    encryption: {
      keySource: 'Microsoft.Automation'
    }
    publicNetworkAccess: true
    sku: {
      name: 'Basic'
    }
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'testconfiguration1'
        properties: {
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnet.id
          }
        }
      }
    ]
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: resourceName
  location: location
  properties: {
    additionalCapabilities: {}
    applicationProfile: {
      galleryApplications: []
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
        storageUri: ''
      }
    }
    extensionsTimeBudget: 'PT1H30M'
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
          properties: {
            primary: true
          }
        }
      ]
    }
    osProfile: {
      adminPassword: null
      adminUsername: 'adminuser'
      allowExtensionOperations: true
      computerName: 'acctest0001'
      linuxConfiguration: {
        disablePasswordAuthentication: false
        patchSettings: {
          assessmentMode: 'ImageDefault'
          patchMode: 'ImageDefault'
        }
        provisionVMAgent: true
        ssh: {
          publicKeys: []
        }
      }
      secrets: []
    }
    priority: 'Regular'
    storageProfile: {
      dataDisks: []
      imageReference: {
        offer: 'UbuntuServer'
        publisher: 'Canonical'
        sku: '16.04-LTS'
        version: 'latest'
      }
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        osType: 'Linux'
        writeAcceleratorEnabled: false
      }
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
  }
}

resource credential 'Microsoft.Automation/automationAccounts/credentials@2020-01-13-preview' = {
  parent: automationAccount
  name: resourceName
  properties: {
    description: ''
    password: null
    userName: 'test_user'
  }
}

resource hybridRunbookWorkerGroup 'Microsoft.Automation/automationAccounts/hybridRunbookWorkerGroups@2021-06-22' = {
  parent: automationAccount
  name: resourceName
  credential: {
    name: credential.name
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  parent: virtualNetwork
  name: 'internal'
  properties: {
    addressPrefix: '10.0.2.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}

resource hybridRunbookWorker 'Microsoft.Automation/automationAccounts/hybridRunbookWorkerGroups/hybridRunbookWorkers@2021-06-22' = {
  parent: hybridRunbookWorkerGroup
  name: 'c7714056-5ba8-4bbe-920e-2993171164eb'
  properties: {
    vmResourceId: virtualMachine.id
  }
}
