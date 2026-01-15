---
title: API change log for Microsoft.CostManagement/exports
description: Describes changes between API versions for Microsoft.CostManagement/exports.
ms.service: azure-resource-manager
ms.topic: reference
---
# API version change log for deployment of Microsoft.CostManagement/exports

This article describes the properties that changed in each API version for [microsoft.costmanagement/exports](~/microsoft.costmanagement/exports.md). It only covers properties that are available during deployments.

## 2025-03-01

Removed:

* FabricLakehouse
* FabricWorkspace
* MicrosoftFabricDestinationSettings

Updated:

* [ExportDeliveryDestination](~/microsoft.costmanagement/2025-03-01/exports.md#exportdeliverydestination): Removed property 'microsoftFabricSettings'


## 2024-10-01-preview

Added:

* [FabricLakehouse](~/microsoft.costmanagement/2024-10-01-preview/exports.md#fabriclakehouse)
* [FabricWorkspace](~/microsoft.costmanagement/2024-10-01-preview/exports.md#fabricworkspace)
* [FilterItems](~/microsoft.costmanagement/2024-10-01-preview/exports.md#filteritems)
* [MicrosoftFabricDestinationSettings](~/microsoft.costmanagement/2024-10-01-preview/exports.md#microsoftfabricdestinationsettings)

Updated:

* [ExportDatasetConfiguration](~/microsoft.costmanagement/2024-10-01-preview/exports.md#exportdatasetconfiguration): Added property 'dataVersion'
* [ExportDatasetConfiguration](~/microsoft.costmanagement/2024-10-01-preview/exports.md#exportdatasetconfiguration): Added property 'filters'
* [ExportDeliveryDestination](~/microsoft.costmanagement/2024-10-01-preview/exports.md#exportdeliverydestination): Added property 'microsoftFabricSettings'
* [ExportDeliveryDestination](~/microsoft.costmanagement/2024-10-01-preview/exports.md#exportdeliverydestination): Added property 'type'
* [ExportProperties](~/microsoft.costmanagement/2024-10-01-preview/exports.md#exportproperties): Added property 'compressionMode'
* [ExportProperties](~/microsoft.costmanagement/2024-10-01-preview/exports.md#exportproperties): Added property 'dataOverwriteBehavior'
* [ExportProperties](~/microsoft.costmanagement/2024-10-01-preview/exports.md#exportproperties): Added property 'exportDescription'
* [ExportProperties](~/microsoft.costmanagement/2024-10-01-preview/exports.md#exportproperties): Added property 'systemSuspensionContext'


## 2024-08-01

No properties added, updated or removed.

## 2023-11-01

No properties added, updated or removed.

## 2023-09-01

No properties added, updated or removed.

## 2023-08-01

Removed:

* FilterItems

Updated:

* [ExportDatasetConfiguration](~/microsoft.costmanagement/2023-08-01/exports.md#exportdatasetconfiguration): Removed property 'dataVersion'
* [ExportDatasetConfiguration](~/microsoft.costmanagement/2023-08-01/exports.md#exportdatasetconfiguration): Removed property 'filters'
* [ExportDeliveryDestination](~/microsoft.costmanagement/2023-08-01/exports.md#exportdeliverydestination): Removed property 'type'
* [ExportProperties](~/microsoft.costmanagement/2023-08-01/exports.md#exportproperties): Removed property 'compressionMode'
* [ExportProperties](~/microsoft.costmanagement/2023-08-01/exports.md#exportproperties): Removed property 'dataOverwriteBehavior'
* [ExportProperties](~/microsoft.costmanagement/2023-08-01/exports.md#exportproperties): Removed property 'exportDescription'
* [ExportProperties](~/microsoft.costmanagement/2023-08-01/exports.md#exportproperties): Removed property 'systemSuspensionContext'


## 2023-07-01-preview

Added:

* [FilterItems](~/microsoft.costmanagement/2023-07-01-preview/exports.md#filteritems)

Updated:

* [ExportDatasetConfiguration](~/microsoft.costmanagement/2023-07-01-preview/exports.md#exportdatasetconfiguration): Added property 'dataVersion'
* [ExportDatasetConfiguration](~/microsoft.costmanagement/2023-07-01-preview/exports.md#exportdatasetconfiguration): Added property 'filters'
* [ExportDeliveryDestination](~/microsoft.costmanagement/2023-07-01-preview/exports.md#exportdeliverydestination): Added property 'type'
* [ExportProperties](~/microsoft.costmanagement/2023-07-01-preview/exports.md#exportproperties): Added property 'compressionMode'
* [ExportProperties](~/microsoft.costmanagement/2023-07-01-preview/exports.md#exportproperties): Added property 'dataOverwriteBehavior'
* [ExportProperties](~/microsoft.costmanagement/2023-07-01-preview/exports.md#exportproperties): Added property 'exportDescription'
* [ExportProperties](~/microsoft.costmanagement/2023-07-01-preview/exports.md#exportproperties): Added property 'systemSuspensionContext'


## 2023-04-01-preview

Added:

* [SystemAssignedServiceIdentity](~/microsoft.costmanagement/2023-04-01-preview/exports.md#systemassignedserviceidentity)

Updated:

* [Microsoft.CostManagement/exports](~/microsoft.costmanagement/2023-04-01-preview/exports.md#microsoftcostmanagementexports): Added property 'identity'
* [Microsoft.CostManagement/exports](~/microsoft.costmanagement/2023-04-01-preview/exports.md#microsoftcostmanagementexports): Added property 'location'


## 2023-03-01

No properties added, updated or removed.

## 2022-10-01

No properties added, updated or removed.

## 2021-10-01

No properties added, updated or removed.

## 2021-01-01

Updated:

* [ExportProperties](~/microsoft.costmanagement/2021-01-01/exports.md#exportproperties): Added property 'partitionData'


## 2020-12-01-preview

Updated:

* [ExportDeliveryDestination](~/microsoft.costmanagement/2020-12-01-preview/exports.md#exportdeliverydestination): Added property 'sasToken'
* [ExportDeliveryDestination](~/microsoft.costmanagement/2020-12-01-preview/exports.md#exportdeliverydestination): Added property 'storageAccount'


## 2020-06-01

Added:

* [ExportDataset](~/microsoft.costmanagement/2020-06-01/exports.md#exportdataset)
* [ExportDatasetConfiguration](~/microsoft.costmanagement/2020-06-01/exports.md#exportdatasetconfiguration)
* [ExportExecutionListResult](~/microsoft.costmanagement/2020-06-01/exports.md#exportexecutionlistresult)
* [ExportTimePeriod](~/microsoft.costmanagement/2020-06-01/exports.md#exporttimeperiod)

Removed:

* QueryAggregation
* QueryComparisonExpression
* QueryDatasetAggregation
* QueryDatasetAutoGenerated
* QueryDatasetConfiguration
* QueryFilterAutoGenerated
* QueryGrouping
* QueryTimePeriod

Updated:

* [ExportProperties](~/microsoft.costmanagement/2020-06-01/exports.md#exportproperties): Added property 'nextRunTimeEstimate'
* [ExportProperties](~/microsoft.costmanagement/2020-06-01/exports.md#exportproperties): Added property 'runHistory'


## 2019-11-01

Added:

* [ExportDefinition](~/microsoft.costmanagement/2019-11-01/exports.md#exportdefinition)
* [QueryDatasetAutoGenerated](~/microsoft.costmanagement/2019-11-01/exports.md#querydatasetautogenerated)
* [QueryFilterAutoGenerated](~/microsoft.costmanagement/2019-11-01/exports.md#queryfilterautogenerated)

Removed:

* QueryDataset
* QueryDefinition
* QueryFilter
* QuerySortingConfiguration

Updated:

* [Microsoft.CostManagement/exports](~/microsoft.costmanagement/2019-11-01/exports.md#microsoftcostmanagementexports): Added property 'eTag'
* [Microsoft.CostManagement/exports](~/microsoft.costmanagement/2019-11-01/exports.md#microsoftcostmanagementexports): Removed property 'tags'


## 2019-10-01

No properties added, updated or removed.

## 2019-09-01

No properties added, updated or removed.

## 2019-01-01

Oldest version tracked in change log
