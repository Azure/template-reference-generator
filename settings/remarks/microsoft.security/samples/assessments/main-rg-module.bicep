param resourceName string = 'acctest0001'
param location string = 'westus'
@secure()
@description('The administrator password for the virtual machine scale set')
param adminPassword string

resource virtualMachineScaleSet 'Microsoft.Compute/virtualMachineScaleSets@2024-11-01' = {
  name: '${resourceName}-vmss'
  location: location
  sku: {
    capacity: 1
    name: 'Standard_B1s'
  }
  properties: {
    orchestrationMode: 'Uniform'
    overprovision: true
    singlePlacementGroup: true
    upgradePolicy: {
      mode: 'Manual'
    }
    virtualMachineProfile: {
      diagnosticsProfile: {
        bootDiagnostics: {
          enabled: false
          storageUri: ''
        }
      }
      extensionProfile: {
        extensionsTimeBudget: 'PT1H30M'
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: 'example'
            properties: {
              primary: true
              dnsSettings: {
                dnsServers: []
              }
              enableAcceleratedNetworking: false
              enableIPForwarding: false
              ipConfigurations: [
                {
                  name: 'internal'
                  properties: {
                    privateIPAddressVersion: 'IPv4'
                    subnet: {}
                    applicationGatewayBackendAddressPools: []
                    applicationSecurityGroups: []
                    loadBalancerBackendAddressPools: []
                    loadBalancerInboundNatPools: []
                    primary: true
                  }
                }
              ]
            }
          }
        ]
      }
      osProfile: {
        computerNamePrefix: '${resourceName}-vmss'
        linuxConfiguration: {
          disablePasswordAuthentication: false
          provisionVMAgent: true
          ssh: {
            publicKeys: []
          }
        }
        secrets: []
        adminPassword: adminPassword
        adminUsername: 'adminuser'
        allowExtensionOperations: true
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
    additionalCapabilities: {}
    doNotRunExtensionsOnOverprovisionedVMs: false
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
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: 'internal'
  parent: virtualNetwork
  properties: {
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    defaultOutboundAccess: true
  }
}

resource assessment 'Microsoft.Security/assessments@2020-01-01' = {
  name: 'fdaaa62c-1d42-45ab-be2f-2af194dd1700'
  scope: virtualMachineScaleSet
  properties: {
    additionalData: {}
    resourceDetails: {
      source: 'Azure'
    }
    status: {
      cause: ''
      code: 'Healthy'
      description: ''
    }
  }
}
