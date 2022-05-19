@description('Location for all resources.')
param location string = resourceGroup().location

@description('Virtual network name.')
param virtualNetworkName string = 'iportalvnet'

@description('Virtual network address range.')
param virtualNetworkAddressRange string = '10.100.0.0/16'

@description('Subnet name.')
param appgwsubnetname string = 'appgwsub'

@description('App Gateway Subnet IP range.')
param appgwsubnetrange string = '10.100.0.0/24'

@description('Web Subnet name.')
param websubnetname string = 'websub'

@description('Web Subnet IP range.')
param websubnetrange string = '10.100.1.0/24'

@description('API Subnet name.')
param apisubnetname string = 'apisub'

@description('API Subnet IP range.')
param apisubnetrange string = '10.100.2.0/24'

@description('Bastion host name.')
param bastionHostName string = 'iportalbastion'

@description('Bastion subnet name.')
param bastionSubnetName string = 'AzureBastionSubnet'

@description('Bastion subnet IP range.')
param bastionSubnetrange string = '10.100.3.0/24'

@description('vNet DNS server configuration.')
param DNSServers array = [
  '10.0.0.1'
  '10.0.0.2'
]


//Create VNET

module VNet 'modules/VNET.bicep'= {
  name: 'VNet'
  params: {
    virtualNetworkName: virtualNetworkName
    virtualNetworkAddressRange: virtualNetworkAddressRange
    appgwsubnetname: appgwsubnetname
    appgwsubnetrange: appgwsubnetrange
    websubnetname: websubnetname
    websubnetrange: websubnetrange
    apisubnetname: apisubnetname
    apisubnetrange: apisubnetrange
    DNSServerAddress: DNSServers
    bastionSubnetName: bastionSubnetName
    bastionsubnetrange: bastionSubnetrange
    location: location
  }
}

//Create Bastion Host
module bastion 'modules/bastion.bicep'= {
  name: 'bastion'
  params: {
    bastionHostName: bastionHostName
    vnetName: virtualNetworkName
    location: location
  }
  dependsOn: [
    VNet
  ]
}




