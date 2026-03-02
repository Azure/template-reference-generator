param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
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
        managedDisk: {
          storageAccountType: 'Premium_LRS'
        }
        name: 'acctvm-250116171212663925OSDisk'
        caching: 'ReadOnly'
        deleteOption: 'Detach'
        diskSizeGB: 127
        osType: 'Windows'
        writeAcceleratorEnabled: false
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

resource dataCollectionRuleAssociation 'Microsoft.Insights/dataCollectionRuleAssociations@2022-06-01' = {
  name: 'azapi_resource.workspace.output.properties.customerId_azapi_resource.resourceGroup.location_DCRA_1'
  scope: virtualMachine
  properties: {
    dataCollectionRuleId: dataCollectionRule.id
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    dnsSettings: {
      dnsServers: []
    }
    enableAcceleratedNetworking: false
    ipConfigurations: [
      {
        properties: {
          subnet: {}
          primary: true
          privateIPAddress: '10.0.0.4'
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {}
        }
        type: 'Microsoft.Network/networkInterfaces/ipConfigurations'
        name: 'testconfiguration1'
      }
    ]
    disableTcpStateTracking: false
    enableIPForwarding: false
    nicType: 'Standard'
    auxiliaryMode: 'None'
    auxiliarySku: 'None'
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

resource dataCollectionEndpoint 'Microsoft.Insights/dataCollectionEndpoints@2022-06-01' = {
  name: '${location}-DCE-1'
  location: 'azapi_resource.resourceGroup.location'
  properties: {
    networkAcls: {
      publicNetworkAccess: 'Enabled'
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
    dataSources: {
      logFiles: [
        {
          filePatterns: [
            'C:\\Windows\\System32\\config\\systemprofile\\AppData\\Local\\Microsoft SQL Server IaaS Agent\\Assessment\\*.csv'
          ]
          format: 'text'
          name: 'Custom-SqlAssessment_CL'
          settings: {
            text: {
              recordStartTimestampFormat: 'ISO 8601'
            }
          }
          streams: [
            'Custom-SqlAssessment_CL'
          ]
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
          destinationPortRange: '1433'
          priority: 1001
          sourceAddressPrefix: '167.220.255.0/25'
          sourcePortRange: '*'
          access: 'Allow'
          destinationAddressPrefixes: []
          destinationPortRanges: []
          direction: 'Inbound'
          protocol: 'Tcp'
          sourceAddressPrefixes: []
          sourcePortRanges: []
          destinationAddressPrefix: '*'
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

resource extension 'Microsoft.Compute/virtualMachines/extensions@2024-07-01' = {
  name: 'AzureMonitorWindowsAgent'
  location: 'westeurope'
  parent: virtualMachine
  properties: {
    suppressFailures: false
    type: 'AzureMonitorWindowsAgent'
    typeHandlerVersion: '1.0'
    autoUpgradeMinorVersion: true
    enableAutomaticUpgrade: true
    publisher: 'Microsoft.Azure.Monitor'
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
    sqlImageSku: 'Developer'
    sqlManagement: 'Full'
    assessmentSettings: {
      enable: true
      runImmediately: false
      schedule: {
        dayOfWeek: 'Monday'
        enable: true
        startTime: '00:00'
        weeklyInterval: 1
      }
    }
    sqlServerLicenseType: 'PAYG'
    enableAutomaticUpgrade: true
    leastPrivilegeMode: 'Enabled'
    sqlImageOffer: 'SQL2017-WS2016'
  }
}
