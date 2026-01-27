param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource integrationAccount 'Microsoft.Logic/integrationAccounts@2019-05-01' = {
  name: resourceName
  location: location
  properties: {}
  sku: {
    name: 'Standard'
  }
}

resource agreement 'Microsoft.Logic/integrationAccounts/agreements@2019-05-01' = {
  parent: integrationAccount
  name: resourceName
  properties: {
    agreementType: 'AS2'
    content: {
      aS2: {
        receiveAgreement: {
          protocolSettings: {
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
            errorSettings: {
              resendIfMDNNotReceived: false
              suspendDuplicateMessage: false
            }
            mdnSettings: {
              dispositionNotificationTo: 'http://localhost'
              micHashingAlgorithm: 'SHA1'
              needMDN: false
              sendInboundMDNToMessageBox: true
              sendMDNAsynchronously: false
              signMDN: false
              signOutboundMDNIfOptional: false
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
              checkCertificateRevocationListOnReceive: false
              checkCertificateRevocationListOnSend: false
              checkDuplicateMessage: false
              compressMessage: false
              encryptMessage: false
              encryptionAlgorithm: 'DES3'
              interchangeDuplicatesValidityDays: 5
              overrideMessageProperties: false
              signMessage: false
              signingAlgorithm: 'Default'
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
          protocolSettings: {
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
            errorSettings: {
              resendIfMDNNotReceived: false
              suspendDuplicateMessage: false
            }
            mdnSettings: {
              dispositionNotificationTo: 'http://localhost'
              micHashingAlgorithm: 'SHA1'
              needMDN: false
              sendInboundMDNToMessageBox: true
              sendMDNAsynchronously: false
              signMDN: false
              signOutboundMDNIfOptional: false
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
              checkCertificateRevocationListOnReceive: false
              checkCertificateRevocationListOnSend: false
              checkDuplicateMessage: false
              compressMessage: false
              encryptMessage: false
              encryptionAlgorithm: 'DES3'
              interchangeDuplicatesValidityDays: 5
              overrideMessageProperties: false
              signMessage: false
              signingAlgorithm: 'Default'
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
    guestPartner: partner2.name
    hostIdentity: {
      qualifier: 'AS2Identity'
      value: 'FabrikamNY'
    }
    hostPartner: partner.name
  }
}

resource partner 'Microsoft.Logic/integrationAccounts/partners@2019-05-01' = {
  parent: integrationAccount
  name: resourceName
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
  parent: integrationAccount
  name: '${resourceName}another'
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
