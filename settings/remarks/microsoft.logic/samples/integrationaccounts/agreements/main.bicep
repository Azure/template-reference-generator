param location string = 'westeurope'
param resourceName string = 'acctest0001'

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
    hostIdentity: {
      qualifier: 'AS2Identity'
      value: 'FabrikamNY'
    }
    agreementType: 'AS2'
    content: {
      aS2: {
        receiveAgreement: {
          protocolSettings: {
            envelopeSettings: {
              transmitFileNameInMimeHeader: false
              autogenerateFileName: false
              fileNameTemplate: '%FILE().ReceivedFileName%'
              messageContentType: 'text/plain'
              suspendMessageOnFileNameGenerationError: true
            }
            errorSettings: {
              resendIfMDNNotReceived: false
              suspendDuplicateMessage: false
            }
            mdnSettings: {
              needMDN: false
              sendInboundMDNToMessageBox: true
              sendMDNAsynchronously: false
              signMDN: false
              signOutboundMDNIfOptional: false
              dispositionNotificationTo: 'http://localhost'
              micHashingAlgorithm: 'SHA1'
            }
            messageConnectionSettings: {
              supportHttpStatusCodeContinue: true
              unfoldHttpHeaders: true
              ignoreCertificateNameMismatch: false
              keepHttpConnectionAlive: true
            }
            securitySettings: {
              enableNRRForOutboundDecodedMessages: false
              enableNRRForOutboundEncodedMessages: false
              enableNRRForOutboundMDN: false
              overrideGroupSigningCertificate: false
              enableNRRForInboundDecodedMessages: false
              enableNRRForInboundEncodedMessages: false
              enableNRRForInboundMDN: false
            }
            validationSettings: {
              compressMessage: false
              encryptionAlgorithm: 'DES3'
              overrideMessageProperties: false
              signMessage: false
              checkCertificateRevocationListOnReceive: false
              checkCertificateRevocationListOnSend: false
              checkDuplicateMessage: false
              encryptMessage: false
              interchangeDuplicatesValidityDays: 5
              signingAlgorithm: 'Default'
            }
            acknowledgementConnectionSettings: {
              keepHttpConnectionAlive: false
              supportHttpStatusCodeContinue: false
              unfoldHttpHeaders: false
              ignoreCertificateNameMismatch: false
            }
          }
          receiverBusinessIdentity: {
            value: 'FabrikamNY'
            qualifier: 'AS2Identity'
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
            acknowledgementConnectionSettings: {
              supportHttpStatusCodeContinue: false
              unfoldHttpHeaders: false
              ignoreCertificateNameMismatch: false
              keepHttpConnectionAlive: false
            }
            envelopeSettings: {
              transmitFileNameInMimeHeader: false
              autogenerateFileName: false
              fileNameTemplate: '%FILE().ReceivedFileName%'
              messageContentType: 'text/plain'
              suspendMessageOnFileNameGenerationError: true
            }
            errorSettings: {
              resendIfMDNNotReceived: false
              suspendDuplicateMessage: false
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
              keepHttpConnectionAlive: true
              supportHttpStatusCodeContinue: true
              unfoldHttpHeaders: true
              ignoreCertificateNameMismatch: false
            }
            securitySettings: {
              enableNRRForOutboundMDN: false
              overrideGroupSigningCertificate: false
              enableNRRForInboundDecodedMessages: false
              enableNRRForInboundEncodedMessages: false
              enableNRRForInboundMDN: false
              enableNRRForOutboundDecodedMessages: false
              enableNRRForOutboundEncodedMessages: false
            }
            validationSettings: {
              checkCertificateRevocationListOnSend: false
              compressMessage: false
              encryptMessage: false
              interchangeDuplicatesValidityDays: 5
              overrideMessageProperties: false
              signMessage: false
              checkCertificateRevocationListOnReceive: false
              checkDuplicateMessage: false
              encryptionAlgorithm: 'DES3'
              signingAlgorithm: 'Default'
            }
          }
        }
      }
    }
    guestIdentity: {
      qualifier: 'AS2Identity'
      value: 'FabrikamDC'
    }
  }
}

resource partner 'Microsoft.Logic/integrationAccounts/partners@2019-05-01' = {
  name: resourceName
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
