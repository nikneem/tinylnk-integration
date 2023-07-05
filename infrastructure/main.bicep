targetScope = 'subscription'

param location string = deployment().location

var systemName = 'tinylnk-integration'

var defaultResourceName = '${systemName}-we'

resource targetResourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: defaultResourceName
  location: location
}

module resourcesModule 'resources.bicep' = {
  name: 'resourcesModule'
  scope: targetResourceGroup
  params: {
    location: location
  }
}
