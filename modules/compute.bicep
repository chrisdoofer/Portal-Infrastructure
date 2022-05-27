@description('Location for all resources.')
param location string = resourceGroup().location

@description('Loop array for Web VMs')
param webvmNames array = [
  'webvm1'
  'webvm2'
]

@description('Loop array for Web VMs')
param apivmNames array = [
  'webvm1'
  'webvm2'
]

//Resource decleration for web UI VM's

resource webVMs 'Microsoft.Compute/virtualMachines@2020-12-01' = [for name in webvmNames: {
  name: name
  location: location
  identity: {
    type:'SystemAssigned'
  }
}]

//Resource decleration for API VM's

resource apiVMs 'Microsoft.Compute/virtualMachines@2020-12-01' = [for name in apivmNames: {
  name: name
  location: location
  identity: {
    type:'SystemAssigned'
  }
}]
