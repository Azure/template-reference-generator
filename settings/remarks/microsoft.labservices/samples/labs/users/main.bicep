@secure()
@description('The administrator password for the lab virtual machine')
param adminPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource lab 'Microsoft.LabServices/labs@2022-08-01' = {
  name: resourceName
  location: location
  properties: {
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
    title: 'Test Title'
    virtualMachineProfile: {
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
        name: 'Classic_Fsv2_2_4GB_128_S_SSD'
        capacity: 1
      }
      usageQuota: 'PT0S'
      useSharedPassword: 'Disabled'
    }
  }
}

resource user 'Microsoft.LabServices/labs/users@2022-08-01' = {
  name: resourceName
  parent: lab
  properties: {
    additionalUsageQuota: 'PT0S'
    email: 'terraform-acctest@hashicorp.com'
  }
}
