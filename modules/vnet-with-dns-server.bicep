@description('The name of the Virtual Network to Create')
param virtualNetworkName string

@description('The address range of the new VNET in CIDR format')
param virtualNetworkAddressRange string

@description('The name of the subnet created in the new VNET')
param appgwsubnetname string

@description('The address range of the subnet created in the new VNET')
param appgwsubnetrange string

@description('The name of the subnet created in the new VNET')
param websubnetname string

@description('The address range of the subnet created in the new VNET')
param websubnetrange string

@description('The name of the subnet created in the new VNET')
param apisubnetname string

@description('The address range of the subnet created in the new VNET')
param apisubnetrange string

@description('The name of the subnet created in the new VNET')
var bastionSubnetName = 'AzureBastionSubnet'

@description('The address range of the subnet created in the new VNET')
param bastionsubnetrange string

@description('The DNS address(es) of the DNS Server(s) used by the VNET')
param DNSServerAddress array

@description('Location for all resources.')
param location string = resourceGroup().location

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-08-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        virtualNetworkAddressRange
      ]
    }
    dhcpOptions: {
      dnsServers: DNSServerAddress
    }
    subnets: [
      {
        name: appgwsubnetname
        properties: {
          addressPrefix: appgwsubnetrange
        }
      }
      {
        name: websubnetname
        properties: {
          addressPrefix: websubnetrange
        }
      }
      {
        name: apisubnetname
        properties: {
          addressPrefix: apisubnetrange
        }
      }
      {
        name: bastionSubnetName
        properties: {
          addressPrefix: bastionsubnetrange
        }
      }
    ]
  }
}
output appgwsubetname string = appgwsubnetname
output appgwsubnetrange string = appgwsubnetrange
output websubnetname string = websubnetname
output websubnetrange string = websubnetrange
output apisubnetname string = apisubnetname
output apisubnetrange string = apisubnetrange
output bastionsubnetname string = bastionSubnetName
output bastionsubnetrange string = bastionsubnetrange
