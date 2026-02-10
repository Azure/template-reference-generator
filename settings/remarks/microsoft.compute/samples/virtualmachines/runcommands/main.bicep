param resourceName string = 'acctest0001'
param location string = 'eastus'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

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

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: 'internal'
  parent: virtualNetwork
  properties: {
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    defaultOutboundAccess: true
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: '${resourceName}-nic'
  location: location
  properties: {
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'internal'
        properties: {
          subnet: {}
          primary: false
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
    enableAcceleratedNetworking: false
  }
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${resourceName}-uai'
  location: location
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: '${resourceName}-vm'
  location: location
  properties: {
    additionalCapabilities: {}
    applicationProfile: {
      galleryApplications: []
    }
    hardwareProfile: {
      vmSize: 'Standard_B2s'
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
      secrets: []
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
        writeAcceleratorEnabled: false
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        osType: 'Linux'
      }
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
        storageUri: ''
      }
    }
    extensionsTimeBudget: 'PT1H30M'
  }
}

resource runCommand 'Microsoft.Compute/virtualMachines/runCommands@2023-03-01' = {
  name: '${resourceName}-runcommand'
  location: location
  parent: virtualMachine
  properties: {
    outputBlobUri: ''
    runAsPassword: ''
    runAsUser: ''
    timeoutInSeconds: 1200
    asyncExecution: false
    errorBlobUri: ''
    parameters: []
    protectedParameters: []
    source: {
      script: 'echo \'hello world\''
    }
    treatFailureAsDeploymentFailure: true
  }
}
