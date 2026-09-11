2. Verifico che le subnet siano contenute nella VNet e non si sovrappongano. 
Elemento	CIDR
VNet	    10.50.0.0/16
web	        10.50.10.0/24
data	    10.50.20.0/24

3. Creo la Vnet

Location    Name
----------  ---------------------
italynorth  rg-cea-network-f3624c

AddressPrefix    Name       PrivateEndpointNetworkPolicies    PrivateLinkServiceNetworkPolicies    ProvisioningState    ResourceGroup
---------------  ---------  --------------------------------  -----------------------------------  -------------------  ---------------------
10.50.20.0/24    snet-data  Disabled                          Enabled                              Succeeded            rg-cea-network-f3624c

4. 
Nel portale ho creato NSG e dopo l'ho configurato con le seguenti impostazioni:
{
  "Access": "Allow",
  "Direction": "Inbound",
  "Port": "5432",
  "Priority": 300,
  "Protocol": "TCP",
  "Source": "10.50.10.0/24"
}

5. 