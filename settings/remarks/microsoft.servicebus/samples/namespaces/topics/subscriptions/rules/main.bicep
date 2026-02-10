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
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
  }
}

resource topic 'Microsoft.ServiceBus/namespaces/topics@2021-06-01-preview' = {
  name: resourceName
  parent: namespace
  properties: {
    enablePartitioning: false
    maxSizeInMegabytes: 5120
    requiresDuplicateDetection: false
    status: 'Active'
    supportOrdering: false
    enableBatchedOperations: false
    enableExpress: false
  }
}

resource subscription 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2021-06-01-preview' = {
  name: resourceName
  parent: topic
  properties: {
    clientAffineProperties: {}
    deadLetteringOnMessageExpiration: false
    enableBatchedOperations: false
    isClientAffine: false
    maxDeliveryCount: 10
    requiresSession: false
    deadLetteringOnFilterEvaluationExceptions: true
    status: 'Active'
  }
}

resource rule 'Microsoft.ServiceBus/namespaces/topics/subscriptions/rules@2021-06-01-preview' = {
  name: resourceName
  parent: subscription
  properties: {
    correlationFilter: {
      contentType: 'test_content_type'
      sessionId: 'test_session_id'
      correlationId: 'test_correlation_id'
      label: 'test_label'
      messageId: 'test_message_id'
      replyTo: 'test_reply_to'
      replyToSessionId: 'test_reply_to_session_id'
      to: 'test_to'
    }
    filterType: 'CorrelationFilter'
  }
}
