---
title: Microsoft.Compute/disks 2024-03-02
description: Azure Microsoft.Compute/disks syntax and properties to use in Azure Resource Manager templates for deploying the resource. API version 2024-03-02
zone_pivot_groups: deployment-languages-reference
ms.service: azure-resource-manager
ms.topic: reference
---
# Microsoft.Compute disks 2024-03-02

> [!div class="op_single_selector" title1="API Versions:"]
> - [Latest](../disks.md)
> - [2024-03-02](../2024-03-02/disks.md)
> - [2023-10-02](../2023-10-02/disks.md)
> - [2023-04-02](../2023-04-02/disks.md)
> - [2023-01-02](../2023-01-02/disks.md)
> - [2022-07-02](../2022-07-02/disks.md)
> - [2022-03-02](../2022-03-02/disks.md)
> - [2021-12-01](../2021-12-01/disks.md)
> - [2021-08-01](../2021-08-01/disks.md)
> - [2021-04-01](../2021-04-01/disks.md)
> - [2020-12-01](../2020-12-01/disks.md)
> - [2020-09-30](../2020-09-30/disks.md)
> - [2020-06-30](../2020-06-30/disks.md)
> - [2020-05-01](../2020-05-01/disks.md)
> - [2019-11-01](../2019-11-01/disks.md)
> - [2019-07-01](../2019-07-01/disks.md)
> - [2019-03-01](../2019-03-01/disks.md)
> - [2018-09-30](../2018-09-30/disks.md)
> - [2018-06-01](../2018-06-01/disks.md)
> - [2018-04-01](../2018-04-01/disks.md)
> - [2017-03-30](../2017-03-30/disks.md)
> - [2016-04-30-preview](../2016-04-30-preview/disks.md)


::: zone pivot="deployment-language-bicep"

## Bicep resource definition

The disks resource type can be deployed with operations that target: 

* **Resource groups** - See [resource group deployment commands](/azure/azure-resource-manager/bicep/deploy-to-resource-group)

For a list of changed properties in each API version, see [change log](~/microsoft.compute/change-log/disks.md).

## Resource format

To create a Microsoft.Compute/disks resource, add the following Bicep to your template.

```bicep
resource symbolicname 'Microsoft.Compute/disks@2024-03-02' = {
  extendedLocation: {
    name: 'string'
    type: 'string'
  }
  location: 'string'
  name: 'string'
  properties: {
    burstingEnabled: bool
    completionPercent: int
    creationData: {
      createOption: 'string'
      elasticSanResourceId: 'string'
      galleryImageReference: {
        communityGalleryImageId: 'string'
        id: 'string'
        lun: int
        sharedGalleryImageId: 'string'
      }
      imageReference: {
        communityGalleryImageId: 'string'
        id: 'string'
        lun: int
        sharedGalleryImageId: 'string'
      }
      logicalSectorSize: int
      performancePlus: bool
      provisionedBandwidthCopySpeed: 'string'
      securityDataUri: 'string'
      sourceResourceId: 'string'
      sourceUri: 'string'
      storageAccountId: 'string'
      uploadSizeBytes: int
    }
    dataAccessAuthMode: 'string'
    diskAccessId: 'string'
    diskIOPSReadOnly: int
    diskIOPSReadWrite: int
    diskMBpsReadOnly: int
    diskMBpsReadWrite: int
    diskSizeGB: int
    encryption: {
      diskEncryptionSetId: 'string'
      type: 'string'
    }
    encryptionSettingsCollection: {
      enabled: bool
      encryptionSettings: [
        {
          diskEncryptionKey: {
            secretUrl: 'string'
            sourceVault: {
              id: 'string'
            }
          }
          keyEncryptionKey: {
            keyUrl: 'string'
            sourceVault: {
              id: 'string'
            }
          }
        }
      ]
      encryptionSettingsVersion: 'string'
    }
    hyperVGeneration: 'string'
    maxShares: int
    networkAccessPolicy: 'string'
    optimizedForFrequentAttach: bool
    osType: 'string'
    publicNetworkAccess: 'string'
    purchasePlan: {
      name: 'string'
      product: 'string'
      promotionCode: 'string'
      publisher: 'string'
    }
    securityProfile: {
      secureVMDiskEncryptionSetId: 'string'
      securityType: 'string'
    }
    supportedCapabilities: {
      acceleratedNetwork: bool
      architecture: 'string'
      diskControllerTypes: 'string'
    }
    supportsHibernation: bool
    tier: 'string'
  }
  sku: {
    name: 'string'
  }
  tags: {
    {customized property}: 'string'
  }
  zones: [
    'string'
  ]
}
```
## Property Values
### Microsoft.Compute/disks

| Name | Description | Value |
| ---- | ----------- | ------------ |
| extendedLocation | The extended location where the disk will be created. Extended location cannot be changed. | [ExtendedLocation](#extendedlocation) |
| location | Resource location | string (required) |
| name | The resource name | string (required) |
| properties | Disk resource properties. | [DiskProperties](#diskproperties) |
| sku | The disks sku name. Can be Standard_LRS, Premium_LRS, StandardSSD_LRS, UltraSSD_LRS, Premium_ZRS, StandardSSD_ZRS, or PremiumV2_LRS. | [DiskSku](#disksku) |
| tags | Resource tags | Dictionary of tag names and values. See [Tags in templates](/azure/azure-resource-manager/management/tag-resources#arm-templates) |
| zones | The Logical zone list for Disk. | string[] |

### CreationData

| Name | Description | Value |
| ---- | ----------- | ------------ |
| createOption | This enumerates the possible sources of a disk's creation. | 'Attach'<br />'Copy'<br />'CopyFromSanSnapshot'<br />'CopyStart'<br />'Empty'<br />'FromImage'<br />'Import'<br />'ImportSecure'<br />'Restore'<br />'Upload'<br />'UploadPreparedSecure' (required) |
| elasticSanResourceId | Required if createOption is CopyFromSanSnapshot. This is the ARM id of the source elastic san volume snapshot. | string |
| galleryImageReference | Required if creating from a Gallery Image. The id/sharedGalleryImageId/communityGalleryImageId of the ImageDiskReference will be the ARM id of the shared galley image version from which to create a disk. | [ImageDiskReference](#imagediskreference) |
| imageReference | Disk source information for PIR or user images. | [ImageDiskReference](#imagediskreference) |
| logicalSectorSize | Logical sector size in bytes for Ultra disks. Supported values are 512 ad 4096. 4096 is the default. | int |
| performancePlus | Set this flag to true to get a boost on the performance target of the disk deployed, see here on the respective performance target. This flag can only be set on disk creation time and cannot be disabled after enabled. | bool |
| provisionedBandwidthCopySpeed | If this field is set on a snapshot and createOption is CopyStart, the snapshot will be copied at a quicker speed. | 'Enhanced'<br />'None' |
| securityDataUri | If createOption is ImportSecure, this is the URI of a blob to be imported into VM guest state. | string |
| sourceResourceId | If createOption is Copy, this is the ARM id of the source snapshot or disk. | string |
| sourceUri | If createOption is Import, this is the URI of a blob to be imported into a managed disk. | string |
| storageAccountId | Required if createOption is Import. The Azure Resource Manager identifier of the storage account containing the blob to import as a disk. | string |
| uploadSizeBytes | If createOption is Upload, this is the size of the contents of the upload including the VHD footer. This value should be between 20972032 (20 MiB + 512 bytes for the VHD footer) and 35183298347520 bytes (32 TiB + 512 bytes for the VHD footer). | int |

### DiskProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| burstingEnabled | Set to true to enable bursting beyond the provisioned performance target of the disk. Bursting is disabled by default. Does not apply to Ultra disks. | bool |
| completionPercent | Percentage complete for the background copy when a resource is created via the CopyStart operation. | int |
| creationData | Disk source information. CreationData information cannot be changed after the disk has been created. | [CreationData](#creationdata) (required) |
| dataAccessAuthMode | Additional authentication requirements when exporting or uploading to a disk or snapshot. | 'AzureActiveDirectory'<br />'None' |
| diskAccessId | ARM id of the DiskAccess resource for using private endpoints on disks. | string |
| diskIOPSReadOnly | The total number of IOPS that will be allowed across all VMs mounting the shared disk as ReadOnly. One operation can transfer between 4k and 256k bytes. | int |
| diskIOPSReadWrite | The number of IOPS allowed for this disk; only settable for UltraSSD disks. One operation can transfer between 4k and 256k bytes. | int |
| diskMBpsReadOnly | The total throughput (MBps) that will be allowed across all VMs mounting the shared disk as ReadOnly. MBps means millions of bytes per second - MB here uses the ISO notation, of powers of 10. | int |
| diskMBpsReadWrite | The bandwidth allowed for this disk; only settable for UltraSSD disks. MBps means millions of bytes per second - MB here uses the ISO notation, of powers of 10. | int |
| diskSizeGB | If creationData.createOption is Empty, this field is mandatory and it indicates the size of the disk to create. If this field is present for updates or creation with other options, it indicates a resize. Resizes are only allowed if the disk is not attached to a running VM, and can only increase the disk's size. | int |
| encryption | Encryption property can be used to encrypt data at rest with customer managed keys or platform managed keys. | [Encryption](#encryption) |
| encryptionSettingsCollection | Encryption settings collection used for Azure Disk Encryption, can contain multiple encryption settings per disk or snapshot. | [EncryptionSettingsCollection](#encryptionsettingscollection) |
| hyperVGeneration | The hypervisor generation of the Virtual Machine. Applicable to OS disks only. | 'V1'<br />'V2' |
| maxShares | The maximum number of VMs that can attach to the disk at the same time. Value greater than one indicates a disk that can be mounted on multiple VMs at the same time. | int |
| networkAccessPolicy | Policy for accessing the disk via network. | 'AllowAll'<br />'AllowPrivate'<br />'DenyAll' |
| optimizedForFrequentAttach | Setting this property to true improves reliability and performance of data disks that are frequently (more than 5 times a day) by detached from one virtual machine and attached to another. This property should not be set for disks that are not detached and attached frequently as it causes the disks to not align with the fault domain of the virtual machine. | bool |
| osType | The Operating System type. | 'Linux'<br />'Windows' |
| publicNetworkAccess | Policy for controlling export on the disk. | 'Disabled'<br />'Enabled' |
| purchasePlan | Purchase plan information for the the image from which the OS disk was created. E.g. - {name: 2019-Datacenter, publisher: MicrosoftWindowsServer, product: WindowsServer} | [PurchasePlan](#purchaseplan) |
| securityProfile | Contains the security related information for the resource. | [DiskSecurityProfile](#disksecurityprofile) |
| supportedCapabilities | List of supported capabilities for the image from which the OS disk was created. | [SupportedCapabilities](#supportedcapabilities) |
| supportsHibernation | Indicates the OS on a disk supports hibernation. | bool |
| tier | Performance tier of the disk (e.g, P4, S10) as described here: https://azure.microsoft.com/en-us/pricing/details/managed-disks/. Does not apply to Ultra disks. | string |

### DiskSecurityProfile

| Name | Description | Value |
| ---- | ----------- | ------------ |
| secureVMDiskEncryptionSetId | ResourceId of the disk encryption set associated to Confidential VM supported disk encrypted with customer managed key | string |
| securityType | Specifies the SecurityType of the VM. Applicable for OS disks only. | 'ConfidentialVM_DiskEncryptedWithCustomerKey'<br />'ConfidentialVM_DiskEncryptedWithPlatformKey'<br />'ConfidentialVM_NonPersistedTPM'<br />'ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey'<br />'TrustedLaunch' |

### DiskSku

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | The sku name. | 'PremiumV2_LRS'<br />'Premium_LRS'<br />'Premium_ZRS'<br />'StandardSSD_LRS'<br />'StandardSSD_ZRS'<br />'Standard_LRS'<br />'UltraSSD_LRS' |

### Encryption

| Name | Description | Value |
| ---- | ----------- | ------------ |
| diskEncryptionSetId | ResourceId of the disk encryption set to use for enabling encryption at rest. | string |
| type | The type of key used to encrypt the data of the disk. | 'EncryptionAtRestWithCustomerKey'<br />'EncryptionAtRestWithPlatformAndCustomerKeys'<br />'EncryptionAtRestWithPlatformKey' |

### EncryptionSettingsCollection

| Name | Description | Value |
| ---- | ----------- | ------------ |
| enabled | Set this flag to true and provide DiskEncryptionKey and optional KeyEncryptionKey to enable encryption. Set this flag to false and remove DiskEncryptionKey and KeyEncryptionKey to disable encryption. If EncryptionSettings is null in the request object, the existing settings remain unchanged. | bool (required) |
| encryptionSettings | A collection of encryption settings, one for each disk volume. | [EncryptionSettingsElement](#encryptionsettingselement)[] |
| encryptionSettingsVersion | Describes what type of encryption is used for the disks. Once this field is set, it cannot be overwritten. '1.0' corresponds to Azure Disk Encryption with AAD app.'1.1' corresponds to Azure Disk Encryption. | string |

### EncryptionSettingsElement

| Name | Description | Value |
| ---- | ----------- | ------------ |
| diskEncryptionKey | Key Vault Secret Url and vault id of the disk encryption key | [KeyVaultAndSecretReference](#keyvaultandsecretreference) |
| keyEncryptionKey | Key Vault Key Url and vault id of the key encryption key. KeyEncryptionKey is optional and when provided is used to unwrap the disk encryption key. | [KeyVaultAndKeyReference](#keyvaultandkeyreference) |

### ExtendedLocation

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | The name of the extended location. | string |
| type | The type of the extended location. | 'EdgeZone' |

### ImageDiskReference

| Name | Description | Value |
| ---- | ----------- | ------------ |
| communityGalleryImageId | A relative uri containing a community Azure Compute Gallery image reference. | string |
| id | A relative uri containing either a Platform Image Repository, user image, or Azure Compute Gallery image reference. | string |
| lun | If the disk is created from an image's data disk, this is an index that indicates which of the data disks in the image to use. For OS disks, this field is null. | int |
| sharedGalleryImageId | A relative uri containing a direct shared Azure Compute Gallery image reference. | string |

### KeyVaultAndKeyReference

| Name | Description | Value |
| ---- | ----------- | ------------ |
| keyUrl | Url pointing to a key or secret in KeyVault | string (required) |
| sourceVault | Resource id of the KeyVault containing the key or secret | [SourceVault](#sourcevault) (required) |

### KeyVaultAndSecretReference

| Name | Description | Value |
| ---- | ----------- | ------------ |
| secretUrl | Url pointing to a key or secret in KeyVault | string (required) |
| sourceVault | Resource id of the KeyVault containing the key or secret | [SourceVault](#sourcevault) (required) |

### PurchasePlan

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | The plan ID. | string (required) |
| product | Specifies the product of the image from the marketplace. This is the same value as Offer under the imageReference element. | string (required) |
| promotionCode | The Offer Promotion Code. | string |
| publisher | The publisher ID. | string (required) |

### ResourceTags

| Name | Description | Value |
| ---- | ----------- | ------------ |

### SourceVault

| Name | Description | Value |
| ---- | ----------- | ------------ |
| id | Resource Id | string |

### SupportedCapabilities

| Name | Description | Value |
| ---- | ----------- | ------------ |
| acceleratedNetwork | True if the image from which the OS disk is created supports accelerated networking. | bool |
| architecture | CPU architecture supported by an OS disk. | 'Arm64'<br />'x64' |
| diskControllerTypes | The disk controllers that an OS disk supports. If set it can be SCSI or SCSI, NVME or NVME, SCSI. | string |

## Usage Examples
### Bicep Samples

Basic sample for Microsoft.Compute/disks@2022-03-02.

```bicep
param location string = 'westeurope'
param resource_name string = 'acctest0001'

resource disk 'Microsoft.Compute/disks@2022-03-02' = {
  location: location
  name: resource_name
  properties: {
    creationData: {
      createOption: 'Empty'
    }
    diskSizeGB: 10
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
    osType: ''
    publicNetworkAccess: 'Enabled'
  }
  sku: {
    name: 'Standard_LRS'
  }
}
```
### Azure Verified Modules

The following [Azure Verified Modules](https://aka.ms/avm) can be used to deploy this resource type.

> [!div class="mx-tableFixed"]
> | Module | Description |
> | ----- | ----- |
> | [Compute Disk](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/compute/disk) | AVM Resource Module for Compute Disk |

### Azure Quickstart Samples

The following [Azure Quickstart templates](https://aka.ms/azqst) contain Bicep samples for deploying this resource type.

> [!div class="mx-tableFixed"]
> | Bicep File | Description |
> | ----- | ----- |
> | [Create Disk & enable protection via Backup Vault](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.dataprotection/backup-create-disk-enable-protection/main.bicep) | Template that creates a disk and enables protection via Backup Vault |
> | [Windows Docker Host with Portainer and Traefik pre-installed](https://github.com/Azure/azure-quickstart-templates/tree/master/application-workloads/traefik/docker-portainer-traefik-windows-vm/main.bicep) | Windows Docker Host with Portainer and Traefik pre-installed |
> | [Windows Server VM with SSH](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.compute/vm-windows-ssh/main.bicep) | Deploy a single Windows VM with Open SSH enabled so that you can connect through SSH using key-based authentication. |


::: zone-end

::: zone pivot="deployment-language-arm-template"

## ARM template resource definition

The disks resource type can be deployed with operations that target: 

* **Resource groups** - See [resource group deployment commands](/azure/azure-resource-manager/templates/deploy-to-resource-group)

For a list of changed properties in each API version, see [change log](~/microsoft.compute/change-log/disks.md).

## Resource format

To create a Microsoft.Compute/disks resource, add the following JSON to your template.

```json
{
  "type": "Microsoft.Compute/disks",
  "apiVersion": "2024-03-02",
  "name": "string",
  "extendedLocation": {
    "name": "string",
    "type": "string"
  },
  "location": "string",
  "properties": {
    "burstingEnabled": "bool",
    "completionPercent": "int",
    "creationData": {
      "createOption": "string",
      "elasticSanResourceId": "string",
      "galleryImageReference": {
        "communityGalleryImageId": "string",
        "id": "string",
        "lun": "int",
        "sharedGalleryImageId": "string"
      },
      "imageReference": {
        "communityGalleryImageId": "string",
        "id": "string",
        "lun": "int",
        "sharedGalleryImageId": "string"
      },
      "logicalSectorSize": "int",
      "performancePlus": "bool",
      "provisionedBandwidthCopySpeed": "string",
      "securityDataUri": "string",
      "sourceResourceId": "string",
      "sourceUri": "string",
      "storageAccountId": "string",
      "uploadSizeBytes": "int"
    },
    "dataAccessAuthMode": "string",
    "diskAccessId": "string",
    "diskIOPSReadOnly": "int",
    "diskIOPSReadWrite": "int",
    "diskMBpsReadOnly": "int",
    "diskMBpsReadWrite": "int",
    "diskSizeGB": "int",
    "encryption": {
      "diskEncryptionSetId": "string",
      "type": "string"
    },
    "encryptionSettingsCollection": {
      "enabled": "bool",
      "encryptionSettings": [
        {
          "diskEncryptionKey": {
            "secretUrl": "string",
            "sourceVault": {
              "id": "string"
            }
          },
          "keyEncryptionKey": {
            "keyUrl": "string",
            "sourceVault": {
              "id": "string"
            }
          }
        }
      ],
      "encryptionSettingsVersion": "string"
    },
    "hyperVGeneration": "string",
    "maxShares": "int",
    "networkAccessPolicy": "string",
    "optimizedForFrequentAttach": "bool",
    "osType": "string",
    "publicNetworkAccess": "string",
    "purchasePlan": {
      "name": "string",
      "product": "string",
      "promotionCode": "string",
      "publisher": "string"
    },
    "securityProfile": {
      "secureVMDiskEncryptionSetId": "string",
      "securityType": "string"
    },
    "supportedCapabilities": {
      "acceleratedNetwork": "bool",
      "architecture": "string",
      "diskControllerTypes": "string"
    },
    "supportsHibernation": "bool",
    "tier": "string"
  },
  "sku": {
    "name": "string"
  },
  "tags": {
    "{customized property}": "string"
  },
  "zones": [ "string" ]
}
```
## Property Values
### Microsoft.Compute/disks

| Name | Description | Value |
| ---- | ----------- | ------------ |
| apiVersion | The api version | '2024-03-02' |
| extendedLocation | The extended location where the disk will be created. Extended location cannot be changed. | [ExtendedLocation](#extendedlocation-1) |
| location | Resource location | string (required) |
| name | The resource name | string (required) |
| properties | Disk resource properties. | [DiskProperties](#diskproperties-1) |
| sku | The disks sku name. Can be Standard_LRS, Premium_LRS, StandardSSD_LRS, UltraSSD_LRS, Premium_ZRS, StandardSSD_ZRS, or PremiumV2_LRS. | [DiskSku](#disksku-1) |
| tags | Resource tags | Dictionary of tag names and values. See [Tags in templates](/azure/azure-resource-manager/management/tag-resources#arm-templates) |
| type | The resource type | 'Microsoft.Compute/disks' |
| zones | The Logical zone list for Disk. | string[] |

### CreationData

| Name | Description | Value |
| ---- | ----------- | ------------ |
| createOption | This enumerates the possible sources of a disk's creation. | 'Attach'<br />'Copy'<br />'CopyFromSanSnapshot'<br />'CopyStart'<br />'Empty'<br />'FromImage'<br />'Import'<br />'ImportSecure'<br />'Restore'<br />'Upload'<br />'UploadPreparedSecure' (required) |
| elasticSanResourceId | Required if createOption is CopyFromSanSnapshot. This is the ARM id of the source elastic san volume snapshot. | string |
| galleryImageReference | Required if creating from a Gallery Image. The id/sharedGalleryImageId/communityGalleryImageId of the ImageDiskReference will be the ARM id of the shared galley image version from which to create a disk. | [ImageDiskReference](#imagediskreference-1) |
| imageReference | Disk source information for PIR or user images. | [ImageDiskReference](#imagediskreference-1) |
| logicalSectorSize | Logical sector size in bytes for Ultra disks. Supported values are 512 ad 4096. 4096 is the default. | int |
| performancePlus | Set this flag to true to get a boost on the performance target of the disk deployed, see here on the respective performance target. This flag can only be set on disk creation time and cannot be disabled after enabled. | bool |
| provisionedBandwidthCopySpeed | If this field is set on a snapshot and createOption is CopyStart, the snapshot will be copied at a quicker speed. | 'Enhanced'<br />'None' |
| securityDataUri | If createOption is ImportSecure, this is the URI of a blob to be imported into VM guest state. | string |
| sourceResourceId | If createOption is Copy, this is the ARM id of the source snapshot or disk. | string |
| sourceUri | If createOption is Import, this is the URI of a blob to be imported into a managed disk. | string |
| storageAccountId | Required if createOption is Import. The Azure Resource Manager identifier of the storage account containing the blob to import as a disk. | string |
| uploadSizeBytes | If createOption is Upload, this is the size of the contents of the upload including the VHD footer. This value should be between 20972032 (20 MiB + 512 bytes for the VHD footer) and 35183298347520 bytes (32 TiB + 512 bytes for the VHD footer). | int |

### DiskProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| burstingEnabled | Set to true to enable bursting beyond the provisioned performance target of the disk. Bursting is disabled by default. Does not apply to Ultra disks. | bool |
| completionPercent | Percentage complete for the background copy when a resource is created via the CopyStart operation. | int |
| creationData | Disk source information. CreationData information cannot be changed after the disk has been created. | [CreationData](#creationdata-1) (required) |
| dataAccessAuthMode | Additional authentication requirements when exporting or uploading to a disk or snapshot. | 'AzureActiveDirectory'<br />'None' |
| diskAccessId | ARM id of the DiskAccess resource for using private endpoints on disks. | string |
| diskIOPSReadOnly | The total number of IOPS that will be allowed across all VMs mounting the shared disk as ReadOnly. One operation can transfer between 4k and 256k bytes. | int |
| diskIOPSReadWrite | The number of IOPS allowed for this disk; only settable for UltraSSD disks. One operation can transfer between 4k and 256k bytes. | int |
| diskMBpsReadOnly | The total throughput (MBps) that will be allowed across all VMs mounting the shared disk as ReadOnly. MBps means millions of bytes per second - MB here uses the ISO notation, of powers of 10. | int |
| diskMBpsReadWrite | The bandwidth allowed for this disk; only settable for UltraSSD disks. MBps means millions of bytes per second - MB here uses the ISO notation, of powers of 10. | int |
| diskSizeGB | If creationData.createOption is Empty, this field is mandatory and it indicates the size of the disk to create. If this field is present for updates or creation with other options, it indicates a resize. Resizes are only allowed if the disk is not attached to a running VM, and can only increase the disk's size. | int |
| encryption | Encryption property can be used to encrypt data at rest with customer managed keys or platform managed keys. | [Encryption](#encryption-1) |
| encryptionSettingsCollection | Encryption settings collection used for Azure Disk Encryption, can contain multiple encryption settings per disk or snapshot. | [EncryptionSettingsCollection](#encryptionsettingscollection-1) |
| hyperVGeneration | The hypervisor generation of the Virtual Machine. Applicable to OS disks only. | 'V1'<br />'V2' |
| maxShares | The maximum number of VMs that can attach to the disk at the same time. Value greater than one indicates a disk that can be mounted on multiple VMs at the same time. | int |
| networkAccessPolicy | Policy for accessing the disk via network. | 'AllowAll'<br />'AllowPrivate'<br />'DenyAll' |
| optimizedForFrequentAttach | Setting this property to true improves reliability and performance of data disks that are frequently (more than 5 times a day) by detached from one virtual machine and attached to another. This property should not be set for disks that are not detached and attached frequently as it causes the disks to not align with the fault domain of the virtual machine. | bool |
| osType | The Operating System type. | 'Linux'<br />'Windows' |
| publicNetworkAccess | Policy for controlling export on the disk. | 'Disabled'<br />'Enabled' |
| purchasePlan | Purchase plan information for the the image from which the OS disk was created. E.g. - {name: 2019-Datacenter, publisher: MicrosoftWindowsServer, product: WindowsServer} | [PurchasePlan](#purchaseplan-1) |
| securityProfile | Contains the security related information for the resource. | [DiskSecurityProfile](#disksecurityprofile-1) |
| supportedCapabilities | List of supported capabilities for the image from which the OS disk was created. | [SupportedCapabilities](#supportedcapabilities-1) |
| supportsHibernation | Indicates the OS on a disk supports hibernation. | bool |
| tier | Performance tier of the disk (e.g, P4, S10) as described here: https://azure.microsoft.com/en-us/pricing/details/managed-disks/. Does not apply to Ultra disks. | string |

### DiskSecurityProfile

| Name | Description | Value |
| ---- | ----------- | ------------ |
| secureVMDiskEncryptionSetId | ResourceId of the disk encryption set associated to Confidential VM supported disk encrypted with customer managed key | string |
| securityType | Specifies the SecurityType of the VM. Applicable for OS disks only. | 'ConfidentialVM_DiskEncryptedWithCustomerKey'<br />'ConfidentialVM_DiskEncryptedWithPlatformKey'<br />'ConfidentialVM_NonPersistedTPM'<br />'ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey'<br />'TrustedLaunch' |

### DiskSku

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | The sku name. | 'PremiumV2_LRS'<br />'Premium_LRS'<br />'Premium_ZRS'<br />'StandardSSD_LRS'<br />'StandardSSD_ZRS'<br />'Standard_LRS'<br />'UltraSSD_LRS' |

### Encryption

| Name | Description | Value |
| ---- | ----------- | ------------ |
| diskEncryptionSetId | ResourceId of the disk encryption set to use for enabling encryption at rest. | string |
| type | The type of key used to encrypt the data of the disk. | 'EncryptionAtRestWithCustomerKey'<br />'EncryptionAtRestWithPlatformAndCustomerKeys'<br />'EncryptionAtRestWithPlatformKey' |

### EncryptionSettingsCollection

| Name | Description | Value |
| ---- | ----------- | ------------ |
| enabled | Set this flag to true and provide DiskEncryptionKey and optional KeyEncryptionKey to enable encryption. Set this flag to false and remove DiskEncryptionKey and KeyEncryptionKey to disable encryption. If EncryptionSettings is null in the request object, the existing settings remain unchanged. | bool (required) |
| encryptionSettings | A collection of encryption settings, one for each disk volume. | [EncryptionSettingsElement](#encryptionsettingselement-1)[] |
| encryptionSettingsVersion | Describes what type of encryption is used for the disks. Once this field is set, it cannot be overwritten. '1.0' corresponds to Azure Disk Encryption with AAD app.'1.1' corresponds to Azure Disk Encryption. | string |

### EncryptionSettingsElement

| Name | Description | Value |
| ---- | ----------- | ------------ |
| diskEncryptionKey | Key Vault Secret Url and vault id of the disk encryption key | [KeyVaultAndSecretReference](#keyvaultandsecretreference-1) |
| keyEncryptionKey | Key Vault Key Url and vault id of the key encryption key. KeyEncryptionKey is optional and when provided is used to unwrap the disk encryption key. | [KeyVaultAndKeyReference](#keyvaultandkeyreference-1) |

### ExtendedLocation

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | The name of the extended location. | string |
| type | The type of the extended location. | 'EdgeZone' |

### ImageDiskReference

| Name | Description | Value |
| ---- | ----------- | ------------ |
| communityGalleryImageId | A relative uri containing a community Azure Compute Gallery image reference. | string |
| id | A relative uri containing either a Platform Image Repository, user image, or Azure Compute Gallery image reference. | string |
| lun | If the disk is created from an image's data disk, this is an index that indicates which of the data disks in the image to use. For OS disks, this field is null. | int |
| sharedGalleryImageId | A relative uri containing a direct shared Azure Compute Gallery image reference. | string |

### KeyVaultAndKeyReference

| Name | Description | Value |
| ---- | ----------- | ------------ |
| keyUrl | Url pointing to a key or secret in KeyVault | string (required) |
| sourceVault | Resource id of the KeyVault containing the key or secret | [SourceVault](#sourcevault-1) (required) |

### KeyVaultAndSecretReference

| Name | Description | Value |
| ---- | ----------- | ------------ |
| secretUrl | Url pointing to a key or secret in KeyVault | string (required) |
| sourceVault | Resource id of the KeyVault containing the key or secret | [SourceVault](#sourcevault-1) (required) |

### PurchasePlan

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | The plan ID. | string (required) |
| product | Specifies the product of the image from the marketplace. This is the same value as Offer under the imageReference element. | string (required) |
| promotionCode | The Offer Promotion Code. | string |
| publisher | The publisher ID. | string (required) |

### ResourceTags

| Name | Description | Value |
| ---- | ----------- | ------------ |

### SourceVault

| Name | Description | Value |
| ---- | ----------- | ------------ |
| id | Resource Id | string |

### SupportedCapabilities

| Name | Description | Value |
| ---- | ----------- | ------------ |
| acceleratedNetwork | True if the image from which the OS disk is created supports accelerated networking. | bool |
| architecture | CPU architecture supported by an OS disk. | 'Arm64'<br />'x64' |
| diskControllerTypes | The disk controllers that an OS disk supports. If set it can be SCSI or SCSI, NVME or NVME, SCSI. | string |

## Usage Examples
### Azure Quickstart Templates

The following [Azure Quickstart templates](https://aka.ms/azqst) deploy this resource type.

> [!div class="mx-tableFixed"]
> | Template | Description |
> | ----- | ----- |
> | [Create a VM from a EfficientIP VHD](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.compute/vm-efficientip-vhd)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.compute%2Fvm-efficientip-vhd%2Fazuredeploy.json) | This template creates a VM from a EfficientIP VHD and let you connect it to an existing VNET that can reside in another Resource Group then the virtual machine |
> | [Create a VM in a new or existing vnet from a custom VHD](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.compute/vm-specialized-vhd-new-or-existing-vnet)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.compute%2Fvm-specialized-vhd-new-or-existing-vnet%2Fazuredeploy.json) | This template creates a VM from a specialized VHD and let you connect it to a new or existing VNET that can reside in another Resource Group than the virtual machine |
> | [Create Disk & enable protection via Backup Vault](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.dataprotection/backup-create-disk-enable-protection)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.dataprotection%2Fbackup-create-disk-enable-protection%2Fazuredeploy.json) | Template that creates a disk and enables protection via Backup Vault |
> | [Create VM from existing VHDs and connect it to existingVNET](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.compute/vm-os-disk-and-data-disk-existing-vnet)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.compute%2Fvm-os-disk-and-data-disk-existing-vnet%2Fazuredeploy.json) | This template creates a VM from VHDs (OS + data disk) and let you connect it to an existing VNET that can reside in another Resource Group then the virtual machine |
> | [Creates an ultra managed disk with a specific sector size](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.compute/ultra-managed-disk)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.compute%2Fultra-managed-disk%2Fazuredeploy.json) | This template creates a new ultra managed disk allowing the user to specify a sector size of either 512 or 4096. |
> | [Deploy a 3 node Percona XtraDB Cluster in Availability Zones](https://github.com/Azure/azure-quickstart-templates/tree/master/application-workloads/mysql/mysql-ha-pxc-zones)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fapplication-workloads%2Fmysql%2Fmysql-ha-pxc-zones%2Fazuredeploy.json) | This template deploys a 3 node MySQL high availability cluster on CentOS 6.5 or Ubuntu 12.04 |
> | [SQL VM Performance Optimized Storage Settings on UltraSSD](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.sqlvirtualmachine/sql-vm-new-storage-ultrassd)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.sqlvirtualmachine%2Fsql-vm-new-storage-ultrassd%2Fazuredeploy.json) | Create a SQL Server Virtual Machine with performance optimized storage settings, using UltraSSD for SQL Log files |
> | [Windows Docker Host with Portainer and Traefik pre-installed](https://github.com/Azure/azure-quickstart-templates/tree/master/application-workloads/traefik/docker-portainer-traefik-windows-vm)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fapplication-workloads%2Ftraefik%2Fdocker-portainer-traefik-windows-vm%2Fazuredeploy.json) | Windows Docker Host with Portainer and Traefik pre-installed |
> | [Windows Server VM with SSH](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.compute/vm-windows-ssh)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.compute%2Fvm-windows-ssh%2Fazuredeploy.json) | Deploy a single Windows VM with Open SSH enabled so that you can connect through SSH using key-based authentication. |


::: zone-end

::: zone pivot="deployment-language-terraform"

## Terraform (AzAPI provider) resource definition

The disks resource type can be deployed with operations that target: 

* **Resource groups**

For a list of changed properties in each API version, see [change log](~/microsoft.compute/change-log/disks.md).

## Resource format

To create a Microsoft.Compute/disks resource, add the following Terraform to your template.

```terraform
resource "azapi_resource" "symbolicname" {
  type = "Microsoft.Compute/disks@2024-03-02"
  name = "string"
  parent_id = "string"
  location = "string"
  tags = {
    {customized property} = "string"
  }
  body = {
    extendedLocation = {
      name = "string"
      type = "string"
    }
    properties = {
      burstingEnabled = bool
      completionPercent = int
      creationData = {
        createOption = "string"
        elasticSanResourceId = "string"
        galleryImageReference = {
          communityGalleryImageId = "string"
          id = "string"
          lun = int
          sharedGalleryImageId = "string"
        }
        imageReference = {
          communityGalleryImageId = "string"
          id = "string"
          lun = int
          sharedGalleryImageId = "string"
        }
        logicalSectorSize = int
        performancePlus = bool
        provisionedBandwidthCopySpeed = "string"
        securityDataUri = "string"
        sourceResourceId = "string"
        sourceUri = "string"
        storageAccountId = "string"
        uploadSizeBytes = int
      }
      dataAccessAuthMode = "string"
      diskAccessId = "string"
      diskIOPSReadOnly = int
      diskIOPSReadWrite = int
      diskMBpsReadOnly = int
      diskMBpsReadWrite = int
      diskSizeGB = int
      encryption = {
        diskEncryptionSetId = "string"
        type = "string"
      }
      encryptionSettingsCollection = {
        enabled = bool
        encryptionSettings = [
          {
            diskEncryptionKey = {
              secretUrl = "string"
              sourceVault = {
                id = "string"
              }
            }
            keyEncryptionKey = {
              keyUrl = "string"
              sourceVault = {
                id = "string"
              }
            }
          }
        ]
        encryptionSettingsVersion = "string"
      }
      hyperVGeneration = "string"
      maxShares = int
      networkAccessPolicy = "string"
      optimizedForFrequentAttach = bool
      osType = "string"
      publicNetworkAccess = "string"
      purchasePlan = {
        name = "string"
        product = "string"
        promotionCode = "string"
        publisher = "string"
      }
      securityProfile = {
        secureVMDiskEncryptionSetId = "string"
        securityType = "string"
      }
      supportedCapabilities = {
        acceleratedNetwork = bool
        architecture = "string"
        diskControllerTypes = "string"
      }
      supportsHibernation = bool
      tier = "string"
    }
    sku = {
      name = "string"
    }
    zones = [
      "string"
    ]
  }
}
```
## Property Values
### Microsoft.Compute/disks

| Name | Description | Value |
| ---- | ----------- | ------------ |
| extendedLocation | The extended location where the disk will be created. Extended location cannot be changed. | [ExtendedLocation](#extendedlocation-2) |
| location | Resource location | string (required) |
| name | The resource name | string (required) |
| properties | Disk resource properties. | [DiskProperties](#diskproperties-2) |
| sku | The disks sku name. Can be Standard_LRS, Premium_LRS, StandardSSD_LRS, UltraSSD_LRS, Premium_ZRS, StandardSSD_ZRS, or PremiumV2_LRS. | [DiskSku](#disksku-2) |
| tags | Resource tags | Dictionary of tag names and values. |
| type | The resource type | "Microsoft.Compute/disks@2024-03-02" |
| zones | The Logical zone list for Disk. | string[] |

### CreationData

| Name | Description | Value |
| ---- | ----------- | ------------ |
| createOption | This enumerates the possible sources of a disk's creation. | 'Attach'<br />'Copy'<br />'CopyFromSanSnapshot'<br />'CopyStart'<br />'Empty'<br />'FromImage'<br />'Import'<br />'ImportSecure'<br />'Restore'<br />'Upload'<br />'UploadPreparedSecure' (required) |
| elasticSanResourceId | Required if createOption is CopyFromSanSnapshot. This is the ARM id of the source elastic san volume snapshot. | string |
| galleryImageReference | Required if creating from a Gallery Image. The id/sharedGalleryImageId/communityGalleryImageId of the ImageDiskReference will be the ARM id of the shared galley image version from which to create a disk. | [ImageDiskReference](#imagediskreference-2) |
| imageReference | Disk source information for PIR or user images. | [ImageDiskReference](#imagediskreference-2) |
| logicalSectorSize | Logical sector size in bytes for Ultra disks. Supported values are 512 ad 4096. 4096 is the default. | int |
| performancePlus | Set this flag to true to get a boost on the performance target of the disk deployed, see here on the respective performance target. This flag can only be set on disk creation time and cannot be disabled after enabled. | bool |
| provisionedBandwidthCopySpeed | If this field is set on a snapshot and createOption is CopyStart, the snapshot will be copied at a quicker speed. | 'Enhanced'<br />'None' |
| securityDataUri | If createOption is ImportSecure, this is the URI of a blob to be imported into VM guest state. | string |
| sourceResourceId | If createOption is Copy, this is the ARM id of the source snapshot or disk. | string |
| sourceUri | If createOption is Import, this is the URI of a blob to be imported into a managed disk. | string |
| storageAccountId | Required if createOption is Import. The Azure Resource Manager identifier of the storage account containing the blob to import as a disk. | string |
| uploadSizeBytes | If createOption is Upload, this is the size of the contents of the upload including the VHD footer. This value should be between 20972032 (20 MiB + 512 bytes for the VHD footer) and 35183298347520 bytes (32 TiB + 512 bytes for the VHD footer). | int |

### DiskProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| burstingEnabled | Set to true to enable bursting beyond the provisioned performance target of the disk. Bursting is disabled by default. Does not apply to Ultra disks. | bool |
| completionPercent | Percentage complete for the background copy when a resource is created via the CopyStart operation. | int |
| creationData | Disk source information. CreationData information cannot be changed after the disk has been created. | [CreationData](#creationdata-2) (required) |
| dataAccessAuthMode | Additional authentication requirements when exporting or uploading to a disk or snapshot. | 'AzureActiveDirectory'<br />'None' |
| diskAccessId | ARM id of the DiskAccess resource for using private endpoints on disks. | string |
| diskIOPSReadOnly | The total number of IOPS that will be allowed across all VMs mounting the shared disk as ReadOnly. One operation can transfer between 4k and 256k bytes. | int |
| diskIOPSReadWrite | The number of IOPS allowed for this disk; only settable for UltraSSD disks. One operation can transfer between 4k and 256k bytes. | int |
| diskMBpsReadOnly | The total throughput (MBps) that will be allowed across all VMs mounting the shared disk as ReadOnly. MBps means millions of bytes per second - MB here uses the ISO notation, of powers of 10. | int |
| diskMBpsReadWrite | The bandwidth allowed for this disk; only settable for UltraSSD disks. MBps means millions of bytes per second - MB here uses the ISO notation, of powers of 10. | int |
| diskSizeGB | If creationData.createOption is Empty, this field is mandatory and it indicates the size of the disk to create. If this field is present for updates or creation with other options, it indicates a resize. Resizes are only allowed if the disk is not attached to a running VM, and can only increase the disk's size. | int |
| encryption | Encryption property can be used to encrypt data at rest with customer managed keys or platform managed keys. | [Encryption](#encryption-2) |
| encryptionSettingsCollection | Encryption settings collection used for Azure Disk Encryption, can contain multiple encryption settings per disk or snapshot. | [EncryptionSettingsCollection](#encryptionsettingscollection-2) |
| hyperVGeneration | The hypervisor generation of the Virtual Machine. Applicable to OS disks only. | 'V1'<br />'V2' |
| maxShares | The maximum number of VMs that can attach to the disk at the same time. Value greater than one indicates a disk that can be mounted on multiple VMs at the same time. | int |
| networkAccessPolicy | Policy for accessing the disk via network. | 'AllowAll'<br />'AllowPrivate'<br />'DenyAll' |
| optimizedForFrequentAttach | Setting this property to true improves reliability and performance of data disks that are frequently (more than 5 times a day) by detached from one virtual machine and attached to another. This property should not be set for disks that are not detached and attached frequently as it causes the disks to not align with the fault domain of the virtual machine. | bool |
| osType | The Operating System type. | 'Linux'<br />'Windows' |
| publicNetworkAccess | Policy for controlling export on the disk. | 'Disabled'<br />'Enabled' |
| purchasePlan | Purchase plan information for the the image from which the OS disk was created. E.g. - {name: 2019-Datacenter, publisher: MicrosoftWindowsServer, product: WindowsServer} | [PurchasePlan](#purchaseplan-2) |
| securityProfile | Contains the security related information for the resource. | [DiskSecurityProfile](#disksecurityprofile-2) |
| supportedCapabilities | List of supported capabilities for the image from which the OS disk was created. | [SupportedCapabilities](#supportedcapabilities-2) |
| supportsHibernation | Indicates the OS on a disk supports hibernation. | bool |
| tier | Performance tier of the disk (e.g, P4, S10) as described here: https://azure.microsoft.com/en-us/pricing/details/managed-disks/. Does not apply to Ultra disks. | string |

### DiskSecurityProfile

| Name | Description | Value |
| ---- | ----------- | ------------ |
| secureVMDiskEncryptionSetId | ResourceId of the disk encryption set associated to Confidential VM supported disk encrypted with customer managed key | string |
| securityType | Specifies the SecurityType of the VM. Applicable for OS disks only. | 'ConfidentialVM_DiskEncryptedWithCustomerKey'<br />'ConfidentialVM_DiskEncryptedWithPlatformKey'<br />'ConfidentialVM_NonPersistedTPM'<br />'ConfidentialVM_VMGuestStateOnlyEncryptedWithPlatformKey'<br />'TrustedLaunch' |

### DiskSku

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | The sku name. | 'PremiumV2_LRS'<br />'Premium_LRS'<br />'Premium_ZRS'<br />'StandardSSD_LRS'<br />'StandardSSD_ZRS'<br />'Standard_LRS'<br />'UltraSSD_LRS' |

### Encryption

| Name | Description | Value |
| ---- | ----------- | ------------ |
| diskEncryptionSetId | ResourceId of the disk encryption set to use for enabling encryption at rest. | string |
| type | The type of key used to encrypt the data of the disk. | 'EncryptionAtRestWithCustomerKey'<br />'EncryptionAtRestWithPlatformAndCustomerKeys'<br />'EncryptionAtRestWithPlatformKey' |

### EncryptionSettingsCollection

| Name | Description | Value |
| ---- | ----------- | ------------ |
| enabled | Set this flag to true and provide DiskEncryptionKey and optional KeyEncryptionKey to enable encryption. Set this flag to false and remove DiskEncryptionKey and KeyEncryptionKey to disable encryption. If EncryptionSettings is null in the request object, the existing settings remain unchanged. | bool (required) |
| encryptionSettings | A collection of encryption settings, one for each disk volume. | [EncryptionSettingsElement](#encryptionsettingselement-2)[] |
| encryptionSettingsVersion | Describes what type of encryption is used for the disks. Once this field is set, it cannot be overwritten. '1.0' corresponds to Azure Disk Encryption with AAD app.'1.1' corresponds to Azure Disk Encryption. | string |

### EncryptionSettingsElement

| Name | Description | Value |
| ---- | ----------- | ------------ |
| diskEncryptionKey | Key Vault Secret Url and vault id of the disk encryption key | [KeyVaultAndSecretReference](#keyvaultandsecretreference-2) |
| keyEncryptionKey | Key Vault Key Url and vault id of the key encryption key. KeyEncryptionKey is optional and when provided is used to unwrap the disk encryption key. | [KeyVaultAndKeyReference](#keyvaultandkeyreference-2) |

### ExtendedLocation

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | The name of the extended location. | string |
| type | The type of the extended location. | 'EdgeZone' |

### ImageDiskReference

| Name | Description | Value |
| ---- | ----------- | ------------ |
| communityGalleryImageId | A relative uri containing a community Azure Compute Gallery image reference. | string |
| id | A relative uri containing either a Platform Image Repository, user image, or Azure Compute Gallery image reference. | string |
| lun | If the disk is created from an image's data disk, this is an index that indicates which of the data disks in the image to use. For OS disks, this field is null. | int |
| sharedGalleryImageId | A relative uri containing a direct shared Azure Compute Gallery image reference. | string |

### KeyVaultAndKeyReference

| Name | Description | Value |
| ---- | ----------- | ------------ |
| keyUrl | Url pointing to a key or secret in KeyVault | string (required) |
| sourceVault | Resource id of the KeyVault containing the key or secret | [SourceVault](#sourcevault-2) (required) |

### KeyVaultAndSecretReference

| Name | Description | Value |
| ---- | ----------- | ------------ |
| secretUrl | Url pointing to a key or secret in KeyVault | string (required) |
| sourceVault | Resource id of the KeyVault containing the key or secret | [SourceVault](#sourcevault-2) (required) |

### PurchasePlan

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | The plan ID. | string (required) |
| product | Specifies the product of the image from the marketplace. This is the same value as Offer under the imageReference element. | string (required) |
| promotionCode | The Offer Promotion Code. | string |
| publisher | The publisher ID. | string (required) |

### ResourceTags

| Name | Description | Value |
| ---- | ----------- | ------------ |

### SourceVault

| Name | Description | Value |
| ---- | ----------- | ------------ |
| id | Resource Id | string |

### SupportedCapabilities

| Name | Description | Value |
| ---- | ----------- | ------------ |
| acceleratedNetwork | True if the image from which the OS disk is created supports accelerated networking. | bool |
| architecture | CPU architecture supported by an OS disk. | 'Arm64'<br />'x64' |
| diskControllerTypes | The disk controllers that an OS disk supports. If set it can be SCSI or SCSI, NVME or NVME, SCSI. | string |

## Usage Examples
### Azure Verified Modules

The following [Azure Verified Modules](https://aka.ms/avm) can be used to deploy this resource type.

> [!div class="mx-tableFixed"]
> | Module | Description |
> | ----- | ----- |
> | [Compute Disk](https://github.com/Azure/terraform-azurerm-avm-res-compute-disk) | AVM Resource Module for Compute Disk |


::: zone-end
