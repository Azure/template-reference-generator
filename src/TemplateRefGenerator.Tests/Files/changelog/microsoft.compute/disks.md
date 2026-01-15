---
title: API change log for Microsoft.Compute/disks
description: Describes changes between API versions for Microsoft.Compute/disks.
ms.service: azure-resource-manager
ms.topic: reference
---
# API version change log for deployment of Microsoft.Compute/disks

This article describes the properties that changed in each API version for [microsoft.compute/disks](~/microsoft.compute/disks.md). It only covers properties that are available during deployments.

## 2025-01-02

Added:

* [AvailabilityPolicy](~/microsoft.compute/2025-01-02/disks.md#availabilitypolicy)

Updated:

* [CreationData](~/microsoft.compute/2025-01-02/disks.md#creationdata): Added property 'instantAccessDurationMinutes'
* [CreationData](~/microsoft.compute/2025-01-02/disks.md#creationdata): Added property 'securityMetadataUri'
* [DiskProperties](~/microsoft.compute/2025-01-02/disks.md#diskproperties): Added property 'availabilityPolicy'
* [SupportedCapabilities](~/microsoft.compute/2025-01-02/disks.md#supportedcapabilities): Added property 'supportedSecurityOption'


## 2024-03-02

Added:

* [DiskPurchasePlan](~/microsoft.compute/2024-03-02/disks.md#diskpurchaseplan)
* [TrackedResourceTags](~/microsoft.compute/2024-03-02/disks.md#trackedresourcetags)

Removed:

* PurchasePlan
* ResourceTags

Updated:

* [Microsoft.Compute/disks](~/microsoft.compute/2024-03-02/disks.md#microsoftcomputedisks): Added property 'systemData'


## 2023-10-02

Updated:

* [CreationData](~/microsoft.compute/2023-10-02/disks.md#creationdata): Added property 'provisionedBandwidthCopySpeed'


## 2023-04-02

Updated:

* [CreationData](~/microsoft.compute/2023-04-02/disks.md#creationdata): Added property 'elasticSanResourceId'
* [DiskProperties](~/microsoft.compute/2023-04-02/disks.md#diskproperties): Added property 'LastOwnershipUpdateTime'


## 2023-01-02

No properties added, updated or removed.

## 2022-07-02

Updated:

* [CreationData](~/microsoft.compute/2022-07-02/disks.md#creationdata): Added property 'performancePlus'
* [DiskProperties](~/microsoft.compute/2022-07-02/disks.md#diskproperties): Added property 'burstingEnabledTime'
* [DiskProperties](~/microsoft.compute/2022-07-02/disks.md#diskproperties): Added property 'optimizedForFrequentAttach'
* [SupportedCapabilities](~/microsoft.compute/2022-07-02/disks.md#supportedcapabilities): Added property 'diskControllerTypes'


## 2022-03-02

Updated:

* [ImageDiskReference](~/microsoft.compute/2022-03-02/disks.md#imagediskreference): Added property 'communityGalleryImageId'
* [ImageDiskReference](~/microsoft.compute/2022-03-02/disks.md#imagediskreference): Added property 'sharedGalleryImageId'


## 2021-12-01

Updated:

* [DiskProperties](~/microsoft.compute/2021-12-01/disks.md#diskproperties): Added property 'dataAccessAuthMode'
* [SupportedCapabilities](~/microsoft.compute/2021-12-01/disks.md#supportedcapabilities): Added property 'architecture'


## 2021-08-01

Updated:

* [CreationData](~/microsoft.compute/2021-08-01/disks.md#creationdata): Added property 'securityDataUri'
* [DiskSecurityProfile](~/microsoft.compute/2021-08-01/disks.md#disksecurityprofile): Added property 'secureVMDiskEncryptionSetId'


## 2021-04-01

Added:

* [SupportedCapabilities](~/microsoft.compute/2021-04-01/disks.md#supportedcapabilities)

Updated:

* [DiskProperties](~/microsoft.compute/2021-04-01/disks.md#diskproperties): Added property 'completionPercent'
* [DiskProperties](~/microsoft.compute/2021-04-01/disks.md#diskproperties): Added property 'publicNetworkAccess'
* [DiskProperties](~/microsoft.compute/2021-04-01/disks.md#diskproperties): Added property 'supportedCapabilities'


## 2020-12-01

Added:

* [DiskSecurityProfile](~/microsoft.compute/2020-12-01/disks.md#disksecurityprofile)

Updated:

* [DiskProperties](~/microsoft.compute/2020-12-01/disks.md#diskproperties): Added property 'propertyUpdatesInProgress'
* [DiskProperties](~/microsoft.compute/2020-12-01/disks.md#diskproperties): Added property 'securityProfile'
* [DiskProperties](~/microsoft.compute/2020-12-01/disks.md#diskproperties): Added property 'supportsHibernation'


## 2020-09-30

Added:

* [ExtendedLocation](~/microsoft.compute/2020-09-30/disks.md#extendedlocation)
* [PurchasePlan](~/microsoft.compute/2020-09-30/disks.md#purchaseplan)

Updated:

* [DiskProperties](~/microsoft.compute/2020-09-30/disks.md#diskproperties): Added property 'burstingEnabled'
* [DiskProperties](~/microsoft.compute/2020-09-30/disks.md#diskproperties): Added property 'purchasePlan'
* [Microsoft.Compute/disks](~/microsoft.compute/2020-09-30/disks.md#microsoftcomputedisks): Added property 'extendedLocation'


## 2020-06-30

Updated:

* [CreationData](~/microsoft.compute/2020-06-30/disks.md#creationdata): Added property 'logicalSectorSize'
* [DiskProperties](~/microsoft.compute/2020-06-30/disks.md#diskproperties): Added property 'tier'


## 2020-05-01

Updated:

* [DiskProperties](~/microsoft.compute/2020-05-01/disks.md#diskproperties): Added property 'diskAccessId'
* [DiskProperties](~/microsoft.compute/2020-05-01/disks.md#diskproperties): Added property 'networkAccessPolicy'


## 2019-11-01

Updated:

* [CreationData](~/microsoft.compute/2019-11-01/disks.md#creationdata): Added property 'galleryImageReference'
* [DiskProperties](~/microsoft.compute/2019-11-01/disks.md#diskproperties): Added property 'diskIOPSReadOnly'
* [DiskProperties](~/microsoft.compute/2019-11-01/disks.md#diskproperties): Added property 'diskMBpsReadOnly'
* [DiskProperties](~/microsoft.compute/2019-11-01/disks.md#diskproperties): Added property 'maxShares'
* [DiskProperties](~/microsoft.compute/2019-11-01/disks.md#diskproperties): Added property 'shareInfo'
* [Microsoft.Compute/disks](~/microsoft.compute/2019-11-01/disks.md#microsoftcomputedisks): Added property 'managedByExtended'


## 2019-07-01

Added:

* [Encryption](~/microsoft.compute/2019-07-01/disks.md#encryption)

Updated:

* [DiskProperties](~/microsoft.compute/2019-07-01/disks.md#diskproperties): Added property 'encryption'


## 2019-03-01

Updated:

* [CreationData](~/microsoft.compute/2019-03-01/disks.md#creationdata): Added property 'sourceUniqueId'
* [CreationData](~/microsoft.compute/2019-03-01/disks.md#creationdata): Added property 'uploadSizeBytes'
* [DiskProperties](~/microsoft.compute/2019-03-01/disks.md#diskproperties): Added property 'diskSizeBytes'
* [DiskProperties](~/microsoft.compute/2019-03-01/disks.md#diskproperties): Added property 'uniqueId'
* [EncryptionSettingsCollection](~/microsoft.compute/2019-03-01/disks.md#encryptionsettingscollection): Added property 'encryptionSettingsVersion'


## 2018-09-30

Added:

* [EncryptionSettingsCollection](~/microsoft.compute/2018-09-30/disks.md#encryptionsettingscollection)
* [EncryptionSettingsElement](~/microsoft.compute/2018-09-30/disks.md#encryptionsettingselement)

Removed:

* EncryptionSettings
* KeyVaultAndKeyReference
* KeyVaultAndSecretReference
* SourceVault

Updated:

* [DiskProperties](~/microsoft.compute/2018-09-30/disks.md#diskproperties): Added property 'diskState'
* [DiskProperties](~/microsoft.compute/2018-09-30/disks.md#diskproperties): Added property 'encryptionSettingsCollection'
* [DiskProperties](~/microsoft.compute/2018-09-30/disks.md#diskproperties): Added property 'hyperVGeneration'
* [DiskProperties](~/microsoft.compute/2018-09-30/disks.md#diskproperties): Removed property 'encryptionSettings'


## 2018-06-01

Updated:

* [DiskProperties](~/microsoft.compute/2018-06-01/disks.md#diskproperties): Added property 'diskIOPSReadWrite'
* [DiskProperties](~/microsoft.compute/2018-06-01/disks.md#diskproperties): Added property 'diskMBpsReadWrite'


## 2018-04-01

No properties added, updated or removed.

## 2017-03-30

Added:

* [DiskSku](~/microsoft.compute/2017-03-30/disks.md#disksku)

Updated:

* [DiskProperties](~/microsoft.compute/2017-03-30/disks.md#diskproperties): Removed property 'accountType'
* [DiskProperties](~/microsoft.compute/2017-03-30/disks.md#diskproperties): Removed property 'ownerId'
* [Microsoft.Compute/disks](~/microsoft.compute/2017-03-30/disks.md#microsoftcomputedisks): Added property 'managedBy'
* [Microsoft.Compute/disks](~/microsoft.compute/2017-03-30/disks.md#microsoftcomputedisks): Added property 'sku'
* [Microsoft.Compute/disks](~/microsoft.compute/2017-03-30/disks.md#microsoftcomputedisks): Added property 'zones'


## 2016-04-30-preview

Oldest version tracked in change log
