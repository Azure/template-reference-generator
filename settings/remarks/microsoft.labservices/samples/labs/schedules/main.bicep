param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the lab virtual machine')
param adminPassword string

resource lab 'Microsoft.LabServices/labs@2022-08-01' = {
  name: resourceName
  location: location
  properties: {
    autoShutdownProfile: {
      shutdownWhenNotConnected: 'Disabled'
      shutdownOnDisconnect: 'Disabled'
      shutdownOnIdle: 'None'
    }
    connectionProfile: {
      webSshAccess: 'None'
      clientRdpAccess: 'None'
      clientSshAccess: 'None'
      webRdpAccess: 'None'
    }
    securityProfile: {
      openAccess: 'Disabled'
    }
    title: 'Test Title'
    virtualMachineProfile: {
      useSharedPassword: 'Disabled'
      additionalCapabilities: {
        installGpuDrivers: 'Disabled'
      }
      adminUser: {
        password: '${adminPassword}'
        username: 'testadmin'
      }
      createOption: 'Image'
      imageReference: {
        offer: '0001-com-ubuntu-server-focal'
        publisher: 'canonical'
        sku: '20_04-lts'
        version: 'latest'
      }
      sku: {
        capacity: 1
        name: 'Classic_Fsv2_2_4GB_128_S_SSD'
      }
      usageQuota: 'PT0S'
    }
  }
}

resource schedule 'Microsoft.LabServices/labs/schedules@2022-08-01' = {
  name: resourceName
  parent: lab
  properties: {
    stopAt: '2023-06-30T04:33:55Z'
    timeZoneId: 'America/Los_Angeles'
  }
}
