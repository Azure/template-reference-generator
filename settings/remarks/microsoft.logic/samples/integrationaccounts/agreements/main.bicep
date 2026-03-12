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
            envelopeSettings: {
              suspendMessageOnFileNameGenerationError: true
              transmitFileNameInMimeHeader: false
              autogenerateFileName: false
              fileNameTemplate: '%FILE().ReceivedFileName%'
              messageContentType: 'text/plain'
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
              encryptMessage: false
              encryptionAlgorithm: 'DES3'
              overrideMessageProperties: false
              checkCertificateRevocationListOnReceive: false
              interchangeDuplicatesValidityDays: 5
              signMessage: false
              signingAlgorithm: 'Default'
              checkCertificateRevocationListOnSend: false
            }
            acknowledgementConnectionSettings: {
              supportHttpStatusCodeContinue: false
              unfoldHttpHeaders: false
              ignoreCertificateNameMismatch: false
              keepHttpConnectionAlive: false
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
          protocolSettings: {
            validationSettings: {
              overrideMessageProperties: false
              signingAlgorithm: 'Default'
              checkDuplicateMessage: false
              compressMessage: false
              encryptionAlgorithm: 'DES3'
              interchangeDuplicatesValidityDays: 5
              signMessage: false
              checkCertificateRevocationListOnReceive: false
              checkCertificateRevocationListOnSend: false
              encryptMessage: false
            }
            acknowledgementConnectionSettings: {
              ignoreCertificateNameMismatch: false
              keepHttpConnectionAlive: false
              supportHttpStatusCodeContinue: false
              unfoldHttpHeaders: false
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
              enableNRRForOutboundDecodedMessages: false
              enableNRRForOutboundEncodedMessages: false
              enableNRRForOutboundMDN: false
              overrideGroupSigningCertificate: false
              enableNRRForInboundDecodedMessages: false
              enableNRRForInboundEncodedMessages: false
              enableNRRForInboundMDN: false
            }
          }
          receiverBusinessIdentity: {
            qualifier: 'AS2Identity'
            value: 'FabrikamDC'
          }
          senderBusinessIdentity: {
            qualifier: 'AS2Identity'
            value: 'FabrikamNY'
          }
        }
      }
    }
    guestIdentity: {
      qualifier: 'AS2Identity'
      value: 'FabrikamDC'
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
