param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string
param resourceName string = 'acctest0001'

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    nicType: 'Standard'
    auxiliarySku: 'None'
    enableIPForwarding: false
    ipConfigurations: [
      {
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        name: 'testconfiguration1'
        properties: {
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {}
          subnet: {}
          primary: true
          privateIPAddress: '10.0.0.4'
        }
      }
    ]
    auxiliaryMode: 'None'
    disableTcpStateTracking: false
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    securityRules: [
      {
        name: 'MSSQLRule'
        properties: {
          destinationAddressPrefix: '*'
          destinationPortRange: '1433'
          sourcePortRange: '*'
          sourcePortRanges: []
          access: 'Allow'
          destinationAddressPrefixes: []
          destinationPortRanges: []
          direction: 'Inbound'
          priority: 1001
          protocol: 'Tcp'
          sourceAddressPrefix: '167.220.255.0/25'
          sourceAddressPrefixes: []
        }
      }
    ]
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    ipTags: []
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    osProfile: {
      adminUsername: 'testadmin'
      adminPassword: adminPassword
      allowExtensionOperations: true
      computerName: 'winhost01'
      secrets: []
      windowsConfiguration: {
        timeZone: 'Pacific Standard Time'
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
        }
        provisionVMAgent: true
      }
    }
    storageProfile: {
      dataDisks: []
      imageReference: {
        offer: 'SQL2017-WS2016'
        publisher: 'MicrosoftSQLServer'
        sku: 'SQLDEV'
        version: 'latest'
      }
      osDisk: {
        diskSizeGB: 127
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        osType: 'Windows'
        writeAcceleratorEnabled: false
        deleteOption: 'Detach'
        name: 'acctvm-250116171212663925OSDisk'
        caching: 'ReadOnly'
        createOption: 'FromImage'
      }
    }
    hardwareProfile: {
      vmSize: 'Standard_F2s'
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: false
          }
          id: networkInterface.id
        }
      ]
    }
  }
}

resource workspace 'Microsoft.OperationalInsights/workspaces@2020-08-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    features: {
      disableLocalAuth: false
      enableLogAccessUsingOnlyResourcePermissions: true
      legacy: 0
      searchVersion: 1
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
  }
}

resource table 'Microsoft.OperationalInsights/workspaces/tables@2023-09-01' = {
  name: 'SqlAssessment_CL'
  parent: workspace
  properties: {
    schema: {
      columns: [
        {
          name: 'TimeGenerated'
          type: 'datetime'
        }
        {
          name: 'RawData'
          type: 'string'
        }
      ]
      name: 'SqlAssessment_CL'
    }
  }
}

resource dataCollectionRule 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: 'azapi_resource.workspace.output.properties.customerId_azapi_resource.resourceGroup.location_DCR_1'
  location: 'azapi_resource.resourceGroup.location'
  dependsOn: [
    table
  ]
  properties: {
    dataSources: {
      logFiles: [
        {
          name: 'Custom-SqlAssessment_CL'
          settings: {
            text: {
              recordStartTimestampFormat: 'ISO 8601'
            }
          }
          streams: [
            'Custom-SqlAssessment_CL'
          ]
          filePatterns: [
            'C:\\Windows\\System32\\config\\systemprofile\\AppData\\Local\\Microsoft SQL Server IaaS Agent\\Assessment\\*.csv'
          ]
          format: 'text'
        }
      ]
    }
    description: ''
    destinations: {
      logAnalytics: [
        {}
      ]
    }
    streamDeclarations: {
      'Custom-SqlAssessment_CL': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'datetime'
          }
          {
            type: 'string'
            name: 'RawData'
          }
        ]
      }
    }
    dataCollectionEndpointId: dataCollectionEndpoint.id
    dataFlows: [
      {
        outputStream: 'Custom-SqlAssessment_CL'
        streams: [
          'Custom-SqlAssessment_CL'
        ]
        transformKql: 'source'
        destinations: []
      }
    ]
  }
}

resource dataCollectionRuleAssociation 'Microsoft.Insights/dataCollectionRuleAssociations@2022-06-01' = {
  name: 'azapi_resource.workspace.output.properties.customerId_azapi_resource.resourceGroup.location_DCRA_1'
  scope: virtualMachine
  properties: {
    dataCollectionRuleId: dataCollectionRule.id
  }
}

resource extension 'Microsoft.Compute/virtualMachines/extensions@2024-07-01' = {
  name: 'AzureMonitorWindowsAgent'
  location: 'westeurope'
  parent: virtualMachine
  properties: {
    publisher: 'Microsoft.Azure.Monitor'
    suppressFailures: false
    type: 'AzureMonitorWindowsAgent'
    typeHandlerVersion: '1.0'
    autoUpgradeMinorVersion: true
    enableAutomaticUpgrade: true
  }
}

resource sqlvirtualMachine 'Microsoft.SqlVirtualMachine/sqlVirtualMachines@2023-10-01' = {
  name: 'azapi_resource.virtualMachine.name'
  location: 'azapi_resource.virtualMachine.location'
  dependsOn: [
    dataCollectionRuleAssociation
    extension
  ]
  properties: {
    leastPrivilegeMode: 'Enabled'
    sqlImageOffer: 'SQL2017-WS2016'
    sqlImageSku: 'Developer'
    sqlManagement: 'Full'
    assessmentSettings: {
      schedule: {
        enable: true
        startTime: '00:00'
        weeklyInterval: 1
        dayOfWeek: 'Monday'
      }
      enable: true
      runImmediately: false
    }
    sqlServerLicenseType: 'PAYG'
    enableAutomaticUpgrade: true
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
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.0.0/24'
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
  }
}

resource dataCollectionEndpoint 'Microsoft.Insights/dataCollectionEndpoints@2022-06-01' = {
  name: '${location}-DCE-1'
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    networkAcls: {
      publicNetworkAccess: 'Enabled'
    }
  }
}
