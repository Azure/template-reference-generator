param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the lab virtual machine')
param adminPassword string

resource lab 'Microsoft.LabServices/labs@2022-08-01' = {
  name: resourceName
  location: location
  properties: {
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
      useSharedPassword: 'Disabled'
      additionalCapabilities: {
        installGpuDrivers: 'Disabled'
      }
      adminUser: {
        username: 'testadmin'
        password: '${adminPassword}'
      }
      createOption: 'Image'
    }
    autoShutdownProfile: {
      shutdownOnDisconnect: 'Disabled'
      shutdownOnIdle: 'None'
      shutdownWhenNotConnected: 'Disabled'
    }
  }
}

resource user 'Microsoft.LabServices/labs/users@2022-08-01' = {
  name: resourceName
  parent: lab
  properties: {
    email: 'terraform-acctest@hashicorp.com'
    additionalUsageQuota: 'PT0S'
  }
}
