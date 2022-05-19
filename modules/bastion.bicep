@description('Name of existing vnet to which Azure Bastion should be deployed')
param vnetName string

@description('Name of Azure Bastion resource')
param bastionHostName string

@description('Azure region for Bastion and virtual network')
param location string

var publicIpAddressName = '${bastionHostName}-pip'
var bastionSubnetName = 'AzureBastionSubnet'

resource publicIp 'Microsoft.Network/publicIpAddresses@2020-05-01' = {
  name: publicIpAddressName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

//reference an existing vnet and create a new subnet under it
resource existingVirtualNetwork 'Microsoft.Network/virtualNetworks@2020-05-01' existing = {
  name: vnetName
}
resource existingbastionsubnet 'Microsoft.Network/virtualNetworks/subnets@2020-05-01' existing = {
  parent: existingVirtualNetwork
  name: bastionSubnetName
}

resource bastionHost 'Microsoft.Network/bastionHosts@2020-05-01' = {
  name: bastionHostName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet: {
            id: existingbastionsubnet.id
          }
          publicIPAddress: {
            id: publicIp.id
          }
        }
      }
    ]
  }
}
