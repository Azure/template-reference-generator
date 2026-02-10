param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource virtualMachineScaleSet 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Standard_F2'
    tier: 'Standard'
  }
  properties: {
    doNotRunExtensionsOnOverprovisionedVMs: false
    scaleInPolicy: {
      forceDeletion: false
      rules: [
        'Default'
      ]
    }
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
              dnsSettings: {
                dnsServers: []
              }
              enableAcceleratedNetworking: false
              enableIPForwarding: false
              ipConfigurations: [
                {
                  name: 'internal'
                  properties: {
                    applicationGatewayBackendAddressPools: []
                    applicationSecurityGroups: []
                    loadBalancerBackendAddressPools: []
                    loadBalancerInboundNatPools: []
                    primary: true
                    privateIPAddressVersion: 'IPv4'
                    subnet: {}
                  }
                }
              ]
              primary: true
            }
          }
        ]
      }
      osProfile: {
        adminUsername: 'adminuser'
        computerNamePrefix: resourceName
        linuxConfiguration: {
          provisionVMAgent: true
          ssh: {
            publicKeys: [
              {
                keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+wWK73dCr+jgQOAxNsHAnNNNMEMWOHYEccp6wJm2gotpr9katuF/ZAdou5AaW1C61slRkHRkpRRX9FA9CYBiitZgvCCz+3nWNN7l/Up54Zps/pHWGZLHNJZRYyAB6j5yVLMVHIHriY49d/GZTZVNB8GoJv9Gakwc/fuEZYYl4YDFiGMBP///TzlI4jhiJzjKnEvqPFki5p2ZRJqcbCiF4pJrxUQR/RXqVFQdbRLZgYfJ8xGB878RENq3yQ39d8dVOkq4edbkzwcUmwwwkYVPIoDGsYLaRHnG+To7FvMeyO7xDVQkMKzopTQV8AuKpyvpqu0a9pWOMaiCyDytO7GGN you@me.com'
                path: '/home/adminuser/.ssh/authorized_keys'
              }
            ]
          }
          disablePasswordAuthentication: true
        }
        secrets: []
      }
      priority: 'Regular'
      storageProfile: {
        osDisk: {
          createOption: 'FromImage'
          managedDisk: {
            storageAccountType: 'Standard_LRS'
          }
          osType: 'Linux'
          writeAcceleratorEnabled: false
          caching: 'ReadWrite'
        }
        dataDisks: []
        imageReference: {
          offer: 'UbuntuServer'
          publisher: 'Canonical'
          sku: '16.04-LTS'
          version: 'latest'
        }
      }
    }
    additionalCapabilities: {}
    orchestrationMode: 'Uniform'
    overprovision: true
    singlePlacementGroup: true
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

resource extension 'Microsoft.Compute/virtualMachineScaleSets/extensions@2023-03-01' = {
  name: resourceName
  parent: virtualMachineScaleSet
  properties: {
    typeHandlerVersion: '2.0'
    autoUpgradeMinorVersion: true
    enableAutomaticUpgrade: false
    publisher: 'Microsoft.Azure.Extensions'
    type: 'CustomScript'
    provisionAfterExtensions: []
    settings: {
      commandToExecute: 'echo $HOSTNAME'
    }
    suppressFailures: false
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
