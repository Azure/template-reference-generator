param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator username for the virtual machine scale set')
param adminUsername string
@secure()
@description('The administrator password for the virtual machine scale set')
param adminPassword string

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

resource autoScaleSetting 'Microsoft.Insights/autoScaleSettings@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    enabled: true
    notifications: []
    profiles: [
      {
        capacity: {
          default: '1'
          maximum: '10'
          minimum: '1'
        }
        name: 'metricRules'
        rules: [
          {
            metricTrigger: {
              timeGrain: 'PT1M'
              timeWindow: 'PT5M'
              dividePerInstance: true
              timeAggregation: 'Last'
              dimensions: []
              metricName: 'Percentage CPU'
              metricNamespace: ''
              operator: 'GreaterThan'
              statistic: 'Average'
              threshold: 75
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT1M'
            }
          }
        ]
      }
    ]
  }
}

resource virtualMachineScaleSet 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Standard'
    capacity: 2
    name: 'Standard_F2'
  }
  properties: {
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
            name: 'TestNetworkProfile-230630033559396108'
            properties: {
              dnsSettings: {
                dnsServers: []
              }
              enableAcceleratedNetworking: false
              enableIPForwarding: false
              ipConfigurations: [
                {
                  name: 'TestIPConfiguration'
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
        linuxConfiguration: {
          disablePasswordAuthentication: false
          provisionVMAgent: true
          ssh: {
            publicKeys: [
              {
                keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDCsTcryUl51Q2VSEHqDRNmceUFo55ZtcIwxl2QITbN1RREti5ml/VTytC0yeBOvnZA4x4CFpdw/lCDPk0yrH9Ei5vVkXmOrExdTlT3qI7YaAzj1tUVlBd4S6LX1F7y6VLActvdHuDDuXZXzCDd/97420jrDfWZqJMlUK/EmCE5ParCeHIRIvmBxcEnGfFIsw8xQZl0HphxWOtJil8qsUWSdMyCiJYYQpMoMliO99X40AUc4/AlsyPyT5ddbKk08YrZ+rKDVHF7o29rh4vi5MmHkVgVQHKiKybWlHq+b71gIAUQk9wrJxD+dqt4igrmDSpIjfjwnd+l5UIn5fJSO5DYV4YT/4hwK7OKmuo7OFHD0WyY5YnkYEMtFgzemnRBdE8ulcT60DQpVgRMXFWHvhyCWy0L6sgj1QWDZlLpvsIvNfHsyhKFMG1frLnMt/nP0+YCcfg+v1JYeCKjeoJxB8DWcRBsjzItY0CGmzP8UYZiYKl/2u+2TgFS5r7NWH11bxoUzjKdaa1NLw+ieA8GlBFfCbfWe6YVB9ggUte4VtYFMZGxOjS2bAiYtfgTKFJv+XqORAwExG6+G2eDxIDyo80/OA9IG7Xv/jwQr7D6KDjDuULFcN/iTxuttoKrHeYz1hf5ZQlBdllwJHYx6fK2g8kha6r2JIQKocvsAXiiONqSfw== hello@world.com'
                path: '/home/myadmin/.ssh/authorized_keys'
              }
            ]
          }
        }
        secrets: []
        adminPassword: adminPassword
        adminUsername: adminUsername
        computerNamePrefix: 'testvm-230630033559396108'
      }
      priority: 'Regular'
      storageProfile: {
        dataDisks: []
        imageReference: {
          publisher: 'Canonical'
          sku: '16.04-LTS'
          version: 'latest'
          offer: 'UbuntuServer'
        }
        osDisk: {
          caching: 'ReadWrite'
          createOption: 'FromImage'
          managedDisk: {
            storageAccountType: 'StandardSSD_LRS'
          }
          osType: 'Linux'
          writeAcceleratorEnabled: false
        }
      }
    }
    additionalCapabilities: {}
    doNotRunExtensionsOnOverprovisionedVMs: false
    orchestrationMode: 'Uniform'
    singlePlacementGroup: true
    overprovision: true
    scaleInPolicy: {
      forceDeletion: false
      rules: [
        'Default'
      ]
    }
    upgradePolicy: {
      mode: 'Manual'
    }
  }
}
