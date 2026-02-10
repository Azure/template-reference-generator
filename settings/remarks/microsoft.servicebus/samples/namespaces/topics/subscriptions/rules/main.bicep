param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 0
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
    disableLocalAuth: false
  }
}

resource topic 'Microsoft.ServiceBus/namespaces/topics@2021-06-01-preview' = {
  name: resourceName
  parent: namespace
  properties: {
    status: 'Active'
    supportOrdering: false
    enableBatchedOperations: false
    enableExpress: false
    enablePartitioning: false
    maxSizeInMegabytes: 5120
    requiresDuplicateDetection: false
  }
}

resource subscription 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2021-06-01-preview' = {
  name: resourceName
  parent: topic
  properties: {
    clientAffineProperties: {}
    deadLetteringOnFilterEvaluationExceptions: true
    deadLetteringOnMessageExpiration: false
    enableBatchedOperations: false
    maxDeliveryCount: 10
    requiresSession: false
    isClientAffine: false
    status: 'Active'
  }
}

resource rule 'Microsoft.ServiceBus/namespaces/topics/subscriptions/rules@2021-06-01-preview' = {
  name: resourceName
  parent: subscription
  properties: {
    correlationFilter: {
      contentType: 'test_content_type'
      correlationId: 'test_correlation_id'
      messageId: 'test_message_id'
      sessionId: 'test_session_id'
      label: 'test_label'
      replyTo: 'test_reply_to'
      replyToSessionId: 'test_reply_to_session_id'
      to: 'test_to'
    }
    filterType: 'CorrelationFilter'
  }
}
