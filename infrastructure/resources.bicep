param location string

var systemName = 'tinylnk-integration'
var defaultResourceName = '${systemName}-ne'

var integrationEnvironment = {
  resourceGroupName: 'mvp-int-env'
  containerRegistryName: 'nvv54gsk4pteu'
  applicationInsights: 'mvp-int-env-ai'
  appConfiguration: 'mvp-int-env-appcfg'
  keyVault: 'mvp-int-env-kv'
  logAnalytics: 'mvp-int-env-log'
  serviceBus: 'mvp-int-env-bus'
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: uniqueString(defaultResourceName)
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: integrationEnvironment.logAnalytics
  scope: resourceGroup(integrationEnvironment.resourceGroupName)
}

resource containerAppsEnvironment 'Microsoft.App/managedEnvironments@2023-04-01-preview' = {
  name: '${defaultResourceName}-env'
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalyticsWorkspace.properties.customerId
        sharedKey: logAnalyticsWorkspace.listKeys().primarySharedKey
      }
    }
  }
}
