@description('Location for all resources.')
param location string = resourceGroup().location

@description('Loop array for Web VMs')
param webvmNames array = [
  'webvm1'
  'webvm2'
]

@description('Loop array for API VMs')
param apivmNames array = [
  'apivm1'
  'apivm2'
]

//Resource decleration for web UI VM's

resource webVMs 'Microsoft.Compute/virtualMachines@2020-12-01' = [for webvmname in webvmNames: {
  name: webvmname
  location: location
  identity: {
    type:'SystemAssigned'
  }
}]

//Resource decleration for API VM's

resource apiVMs 'Microsoft.Compute/virtualMachines@2020-12-01' = [for apivmname in apivmNames: {
  name: apivmname
  location: location
  identity: {
    type:'SystemAssigned'
  }
}]
