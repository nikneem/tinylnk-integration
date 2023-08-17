param location string

var systemName = 'tinylnk-integration'
var defaultResourceName = '${systemName}-ne'

var apexHostName = 'tinylnk.nl'
var apiHostName = 'api.tinylnk.nl'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: uniqueString(defaultResourceName)
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: '${defaultResourceName}-log'
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: '${defaultResourceName}-ai'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    IngestionMode: 'LogAnalytics'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
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
  resource apexManagedCertificate 'managedCertificates' = {
    name: '${replace(apexHostName, '.', '-')}-cert'
    location: location
    properties: {
      domainControlValidation: 'HTTP'
      subjectName: apexHostName
    }
  }
  resource apiManagedCertificate 'managedCertificates' = {
    name: '${replace(apiHostName, '.', '-')}-cert'
    location: location
    properties: {
      domainControlValidation: 'CNAME'
      subjectName: apiHostName
    }
  }

}

resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: defaultResourceName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enableRbacAuthorization: true
  }
}

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2022-12-01' = {
  name: replace(defaultResourceName, '-', '')
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    adminUserEnabled: true
  }
}

resource serviceBus 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' = {
  name: '${defaultResourceName}-bus'
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }

  resource queue 'queues' = {
    name: 'hits'
  }
}
