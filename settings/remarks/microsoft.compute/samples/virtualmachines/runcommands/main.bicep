param resourceName string = 'acctest0001'
param location string = 'eastus'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${resourceName}-uai'
  location: location
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: '${resourceName}-vm'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2s'
    }
    priority: 'Regular'
    storageProfile: {
      dataDisks: []
      imageReference: {
        offer: '0001-com-ubuntu-server-jammy'
        publisher: 'Canonical'
        sku: '22_04-lts'
        version: 'latest'
      }
      osDisk: {
        osType: 'Linux'
        writeAcceleratorEnabled: false
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
      }
    }
    applicationProfile: {
      galleryApplications: []
    }
    extensionsTimeBudget: 'PT1H30M'
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
      secrets: []
      adminPassword: adminPassword
      adminUsername: 'adminuser'
      allowExtensionOperations: true
      computerName: '${resourceName}-vm'
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
    }
    additionalCapabilities: {}
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
        storageUri: ''
      }
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: '${resourceName}-vnet'
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
    privateEndpointVNetPolicies: 'Disabled'
    subnets: []
  }
}

resource runCommand 'Microsoft.Compute/virtualMachines/runCommands@2023-03-01' = {
  name: '${resourceName}-runcommand'
  location: location
  parent: virtualMachine
  properties: {
    parameters: []
    protectedParameters: []
    runAsUser: ''
    source: {
      script: 'echo \'hello world\''
    }
    timeoutInSeconds: 1200
    treatFailureAsDeploymentFailure: true
    asyncExecution: false
    errorBlobUri: ''
    outputBlobUri: ''
    runAsPassword: ''
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: 'internal'
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.2.0/24'
    defaultOutboundAccess: true
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: '${resourceName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'internal'
        properties: {
          primary: false
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
        }
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}
