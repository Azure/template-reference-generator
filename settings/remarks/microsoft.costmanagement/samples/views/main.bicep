targetScope = 'subscription'

param resourceName string = 'acctest0001'

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
      }
      timeframe: 'MonthToDate'
      type: 'Usage'
    }
  }
}
