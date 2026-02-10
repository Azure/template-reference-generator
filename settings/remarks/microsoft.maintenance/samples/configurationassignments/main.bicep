param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'testconfiguration1'
        properties: {
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
        }
      }
    ]
    enableAcceleratedNetworking: false
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: resourceName
  location: location
  properties: {
    osProfile: {
      secrets: []
      adminPassword: adminPassword
      adminUsername: 'adminuser'
      allowExtensionOperations: true
      computerName: resourceName
      linuxConfiguration: {
        provisionVMAgent: true
        ssh: {
          publicKeys: []
        }
        disablePasswordAuthentication: false
        patchSettings: {
          assessmentMode: 'ImageDefault'
          patchMode: 'ImageDefault'
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
    priority: 'Regular'
    storageProfile: {
      imageReference: {
        sku: '16.04-LTS'
        version: 'latest'
        offer: 'UbuntuServer'
        publisher: 'Canonical'
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
      dataDisks: []
    }
    applicationProfile: {
      galleryApplications: []
    }
    hardwareProfile: {
      vmSize: 'Standard_F2'
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

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: 'internal'
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.2.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}

resource configurationAssignment 'Microsoft.Maintenance/configurationAssignments@2022-07-01-preview' = {
  name: resourceName
  scope: virtualMachine
  properties: {}
}

resource maintenanceConfiguration 'Microsoft.Maintenance/maintenanceConfigurations@2022-07-01-preview' = {
  name: resourceName
  location: location
  properties: {
    extensionProperties: {}
    maintenanceScope: 'SQLDB'
    namespace: 'Microsoft.Maintenance'
    visibility: 'Custom'
  }
}
