@secure()
@description('The administrator password for the lab virtual machine')
param adminPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource lab 'Microsoft.LabServices/labs@2022-08-01' = {
  name: resourceName
  location: location
  properties: {
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
    autoShutdownProfile: {
      shutdownOnDisconnect: 'Disabled'
      shutdownOnIdle: 'None'
      shutdownWhenNotConnected: 'Disabled'
    }
    connectionProfile: {
      clientRdpAccess: 'None'
      clientSshAccess: 'None'
      webRdpAccess: 'None'
      webSshAccess: 'None'
    }
    securityProfile: {
      openAccess: 'Disabled'
    }
  }
}

resource schedule 'Microsoft.LabServices/labs/schedules@2022-08-01' = {
  name: resourceName
  parent: lab
  properties: {
    timeZoneId: 'America/Los_Angeles'
    stopAt: '2023-06-30T04:33:55Z'
  }
}
