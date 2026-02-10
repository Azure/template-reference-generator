param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource virtualMachineScaleSet 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Standard'
    capacity: 1
    name: 'Standard_F2'
  }
  properties: {
    singlePlacementGroup: true
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
              primary: true
              dnsSettings: {
                dnsServers: []
              }
              enableAcceleratedNetworking: false
            }
          }
        ]
      }
      osProfile: {
        secrets: []
        adminUsername: 'adminuser'
        computerNamePrefix: resourceName
        linuxConfiguration: {
          disablePasswordAuthentication: true
          provisionVMAgent: true
          ssh: {
            publicKeys: [
              {
                keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+wWK73dCr+jgQOAxNsHAnNNNMEMWOHYEccp6wJm2gotpr9katuF/ZAdou5AaW1C61slRkHRkpRRX9FA9CYBiitZgvCCz+3nWNN7l/Up54Zps/pHWGZLHNJZRYyAB6j5yVLMVHIHriY49d/GZTZVNB8GoJv9Gakwc/fuEZYYl4YDFiGMBP///TzlI4jhiJzjKnEvqPFki5p2ZRJqcbCiF4pJrxUQR/RXqVFQdbRLZgYfJ8xGB878RENq3yQ39d8dVOkq4edbkzwcUmwwwkYVPIoDGsYLaRHnG+To7FvMeyO7xDVQkMKzopTQV8AuKpyvpqu0a9pWOMaiCyDytO7GGN you@me.com'
                path: '/home/adminuser/.ssh/authorized_keys'
              }
            ]
          }
        }
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
          writeAcceleratorEnabled: false
          caching: 'ReadWrite'
          createOption: 'FromImage'
          managedDisk: {
            storageAccountType: 'Standard_LRS'
          }
          osType: 'Linux'
        }
      }
    }
    additionalCapabilities: {}
    doNotRunExtensionsOnOverprovisionedVMs: false
    orchestrationMode: 'Uniform'
    overprovision: true
    scaleInPolicy: {
      rules: [
        'Default'
      ]
      forceDeletion: false
    }
    upgradePolicy: {
      mode: 'Manual'
    }
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

resource extension 'Microsoft.Compute/virtualMachineScaleSets/extensions@2023-03-01' = {
  name: resourceName
  parent: virtualMachineScaleSet
  properties: {
    autoUpgradeMinorVersion: true
    enableAutomaticUpgrade: false
    publisher: 'Microsoft.Azure.Extensions'
    settings: {
      commandToExecute: 'echo $HOSTNAME'
    }
    suppressFailures: false
    typeHandlerVersion: '2.0'
    provisionAfterExtensions: []
    type: 'CustomScript'
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: 'internal'
  parent: virtualNetwork
  properties: {
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
  }
}
