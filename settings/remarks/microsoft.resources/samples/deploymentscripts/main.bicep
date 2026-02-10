param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource deploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: resourceName
  location: location
  kind: 'AzurePowerShell'
  properties: {
    timeout: 'P1D'
    azPowerShellVersion: '8.3'
    cleanupPreference: 'Always'
    environmentVariables: null
    retentionInterval: 'P1D'
    scriptContent: '''		$output = ''Hello''
		Write-Output $output
		$DeploymentScriptOutputs = @{}
		$DeploymentScriptOutputs[''text''] = $output
'''
    supportingScriptUris: null
  }
}
