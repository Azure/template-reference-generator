param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource integrationAccount 'Microsoft.Logic/integrationAccounts@2019-05-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {}
}

resource agreement 'Microsoft.Logic/integrationAccounts/agreements@2019-05-01' = {
  name: resourceName
  parent: integrationAccount
  properties: {
    agreementType: 'AS2'
    content: {
      aS2: {
        receiveAgreement: {
          protocolSettings: {
            mdnSettings: {
              sendInboundMDNToMessageBox: true
              sendMDNAsynchronously: false
              signMDN: false
              signOutboundMDNIfOptional: false
              dispositionNotificationTo: 'http://localhost'
              micHashingAlgorithm: 'SHA1'
              needMDN: false
            }
            messageConnectionSettings: {
              ignoreCertificateNameMismatch: false
              keepHttpConnectionAlive: true
              supportHttpStatusCodeContinue: true
              unfoldHttpHeaders: true
            }
            securitySettings: {
              enableNRRForInboundEncodedMessages: false
              enableNRRForInboundMDN: false
              enableNRRForOutboundDecodedMessages: false
              enableNRRForOutboundEncodedMessages: false
              enableNRRForOutboundMDN: false
              overrideGroupSigningCertificate: false
              enableNRRForInboundDecodedMessages: false
            }
            validationSettings: {
              interchangeDuplicatesValidityDays: 5
              overrideMessageProperties: false
              signingAlgorithm: 'Default'
              checkCertificateRevocationListOnReceive: false
              checkCertificateRevocationListOnSend: false
              checkDuplicateMessage: false
              compressMessage: false
              encryptionAlgorithm: 'DES3'
              signMessage: false
              encryptMessage: false
            }
            acknowledgementConnectionSettings: {
              unfoldHttpHeaders: false
              ignoreCertificateNameMismatch: false
              keepHttpConnectionAlive: false
              supportHttpStatusCodeContinue: false
            }
            envelopeSettings: {
              autogenerateFileName: false
              fileNameTemplate: '%FILE().ReceivedFileName%'
              messageContentType: 'text/plain'
              suspendMessageOnFileNameGenerationError: true
              transmitFileNameInMimeHeader: false
            }
            errorSettings: {
              resendIfMDNNotReceived: false
              suspendDuplicateMessage: false
            }
          }
          receiverBusinessIdentity: {
            qualifier: 'AS2Identity'
            value: 'FabrikamNY'
          }
          senderBusinessIdentity: {
            qualifier: 'AS2Identity'
            value: 'FabrikamDC'
          }
        }
        sendAgreement: {
          receiverBusinessIdentity: {
            qualifier: 'AS2Identity'
            value: 'FabrikamDC'
          }
          senderBusinessIdentity: {
            qualifier: 'AS2Identity'
            value: 'FabrikamNY'
          }
          protocolSettings: {
            errorSettings: {
              suspendDuplicateMessage: false
              resendIfMDNNotReceived: false
            }
            mdnSettings: {
              micHashingAlgorithm: 'SHA1'
              needMDN: false
              sendInboundMDNToMessageBox: true
              sendMDNAsynchronously: false
              signMDN: false
              signOutboundMDNIfOptional: false
              dispositionNotificationTo: 'http://localhost'
            }
            messageConnectionSettings: {
              ignoreCertificateNameMismatch: false
              keepHttpConnectionAlive: true
              supportHttpStatusCodeContinue: true
              unfoldHttpHeaders: true
            }
            securitySettings: {
              enableNRRForInboundDecodedMessages: false
              enableNRRForInboundEncodedMessages: false
              enableNRRForInboundMDN: false
              enableNRRForOutboundDecodedMessages: false
              enableNRRForOutboundEncodedMessages: false
              enableNRRForOutboundMDN: false
              overrideGroupSigningCertificate: false
            }
            validationSettings: {
              checkDuplicateMessage: false
              compressMessage: false
              overrideMessageProperties: false
              signMessage: false
              signingAlgorithm: 'Default'
              checkCertificateRevocationListOnReceive: false
              checkCertificateRevocationListOnSend: false
              encryptMessage: false
              encryptionAlgorithm: 'DES3'
              interchangeDuplicatesValidityDays: 5
            }
            acknowledgementConnectionSettings: {
              ignoreCertificateNameMismatch: false
              keepHttpConnectionAlive: false
              supportHttpStatusCodeContinue: false
              unfoldHttpHeaders: false
            }
            envelopeSettings: {
              autogenerateFileName: false
              fileNameTemplate: '%FILE().ReceivedFileName%'
              messageContentType: 'text/plain'
              suspendMessageOnFileNameGenerationError: true
              transmitFileNameInMimeHeader: false
            }
          }
        }
      }
    }
    guestIdentity: {
      value: 'FabrikamDC'
      qualifier: 'AS2Identity'
    }
    hostIdentity: {
      qualifier: 'AS2Identity'
      value: 'FabrikamNY'
    }
  }
}

resource partner 'Microsoft.Logic/integrationAccounts/partners@2019-05-01' = {
  name: resourceName
  parent: integrationAccount
  properties: {
    partnerType: 'B2B'
    content: {
      b2b: {
        businessIdentities: [
          {
            value: 'FabrikamNY'
            qualifier: 'AS2Identity'
          }
        ]
      }
    }
  }
}

resource partner2 'Microsoft.Logic/integrationAccounts/partners@2019-05-01' = {
  name: '${resourceName}another'
  parent: integrationAccount
  properties: {
    content: {
      b2b: {
        businessIdentities: [
          {
            qualifier: 'AS2Identity'
            value: 'FabrikamNY'
          }
        ]
      }
    }
    partnerType: 'B2B'
  }
}
