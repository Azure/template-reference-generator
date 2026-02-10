param resourceName string = 'acctest0001'
param location string = 'eastus'

resource view 'Microsoft.CostManagement/views@2022-10-01' = {
  name: resourceName
  properties: {
    accumulated: 'False'
    chart: 'StackedColumn'
    displayName: 'Test View wgvtl'
    kpis: [
      {
        enabled: true
        type: 'Forecast'
      }
    ]
    pivots: [
      {
        name: 'ServiceName'
        type: 'Dimension'
      }
      {
        name: 'ResourceLocation'
        type: 'Dimension'
      }
      {
        name: 'ResourceGroupName'
        type: 'Dimension'
      }
    ]
    query: {
      dataSet: {
        grouping: [
          {
            name: 'ResourceGroupName'
            type: 'Dimension'
          }
        ]
        sorting: [
          {
            direction: 'Ascending'
            name: 'BillingMonth'
          }
        ]
        aggregation: {
          totalCost: {
            function: 'Sum'
            name: 'Cost'
          }
          totalCostUSD: {
            function: 'Sum'
            name: 'CostUSD'
          }
        }
        granularity: 'Monthly'
      }
      timeframe: 'MonthToDate'
      type: 'Usage'
    }
  }
}
