param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'internal'
        properties: {
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
        }
      }
    ]
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: resourceName
  location: location
  properties: {
    diagnosticsProfile: {
      bootDiagnostics: {
        storageUri: ''
        enabled: false
      }
    }
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
          enableHotpatching: false
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
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
    priority: 'Regular'
    storageProfile: {
      dataDisks: []
      imageReference: {
        offer: 'WindowsServer'
        publisher: 'MicrosoftWindowsServer'
        sku: '2016-Datacenter'
        version: 'latest'
      }
      osDisk: {
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        osType: 'Windows'
        writeAcceleratorEnabled: false
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    additionalCapabilities: {}
    applicationProfile: {
      galleryApplications: []
    }
    extensionsTimeBudget: 'PT1H30M'
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
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
  }
}

resource guestConfigurationAssignment 'Microsoft.GuestConfiguration/guestConfigurationAssignments@2020-06-25' = {
  name: 'WhitelistedApplication'
  location: location
  scope: virtualMachine
  properties: {
    guestConfiguration: {
      contentHash: ''
      contentUri: ''
      name: 'WhitelistedApplication'
      version: '1.*'
      assignmentType: ''
      configurationParameter: [
        {
          name: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
          value: 'NotePad,sql'
        }
      ]
    }
  }
}
