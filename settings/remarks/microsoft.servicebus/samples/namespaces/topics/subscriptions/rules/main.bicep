param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Standard'
    capacity: 0
    name: 'Standard'
  }
  properties: {
    zoneRedundant: false
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
  }
}

resource topic 'Microsoft.ServiceBus/namespaces/topics@2021-06-01-preview' = {
  name: resourceName
  parent: namespace
  properties: {
    enableBatchedOperations: false
    enableExpress: false
    enablePartitioning: false
    maxSizeInMegabytes: 5120
    requiresDuplicateDetection: false
    status: 'Active'
    supportOrdering: false
  }
}

resource subscription 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2021-06-01-preview' = {
  name: resourceName
  parent: topic
  properties: {
    enableBatchedOperations: false
    isClientAffine: false
    requiresSession: false
    clientAffineProperties: {}
    deadLetteringOnFilterEvaluationExceptions: true
    deadLetteringOnMessageExpiration: false
    maxDeliveryCount: 10
    status: 'Active'
  }
}

resource rule 'Microsoft.ServiceBus/namespaces/topics/subscriptions/rules@2021-06-01-preview' = {
  name: resourceName
  parent: subscription
  properties: {
    correlationFilter: {
      correlationId: 'test_correlation_id'
      label: 'test_label'
      messageId: 'test_message_id'
      replyToSessionId: 'test_reply_to_session_id'
      sessionId: 'test_session_id'
      contentType: 'test_content_type'
      replyTo: 'test_reply_to'
      to: 'test_to'
    }
    filterType: 'CorrelationFilter'
  }
}
