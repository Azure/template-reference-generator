param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the lab virtual machine')
param adminPassword string

resource lab 'Microsoft.LabServices/labs@2022-08-01' = {
  name: resourceName
  location: location
  properties: {
    title: 'Test Title'
    virtualMachineProfile: {
      usageQuota: 'PT0S'
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
        publisher: 'canonical'
        sku: '20_04-lts'
        version: 'latest'
        offer: '0001-com-ubuntu-server-focal'
      }
      sku: {
        capacity: 1
        name: 'Classic_Fsv2_2_4GB_128_S_SSD'
      }
    }
    autoShutdownProfile: {
      shutdownOnIdle: 'None'
      shutdownWhenNotConnected: 'Disabled'
      shutdownOnDisconnect: 'Disabled'
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
