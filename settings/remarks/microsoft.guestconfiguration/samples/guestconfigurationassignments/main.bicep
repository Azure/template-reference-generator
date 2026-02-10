param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

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
    priority: 'Regular'
    hardwareProfile: {
      vmSize: 'Standard_F2'
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
      computerName: 'acctestvmdro23'
      secrets: []
      windowsConfiguration: {
        enableAutomaticUpdates: true
        patchSettings: {
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
          patchMode: 'AutomaticByOS'
        }
        provisionVMAgent: true
        winRM: {
          listeners: []
        }
      }
      adminPassword: adminPassword
      adminUsername: 'adminuser'
      allowExtensionOperations: true
    }
    storageProfile: {
      dataDisks: []
      imageReference: {
        version: 'latest'
        offer: 'WindowsServer'
        publisher: 'MicrosoftWindowsServer'
        sku: '2016-Datacenter'
      }
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        osType: 'Windows'
        writeAcceleratorEnabled: false
      }
    }
  }
}

resource guestConfigurationAssignment 'Microsoft.GuestConfiguration/guestConfigurationAssignments@2020-06-25' = {
  name: 'WhitelistedApplication'
  location: location
  scope: virtualMachine
  properties: {
    guestConfiguration: {
      name: 'WhitelistedApplication'
      version: '1.*'
      assignmentType: ''
      configurationParameter: [
        {
          value: 'NotePad,sql'
          name: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        }
      ]
      contentHash: ''
      contentUri: ''
    }
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'internal'
        properties: {
          subnet: {}
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: 'internal'
  parent: virtualNetwork
  properties: {
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
  }
}
