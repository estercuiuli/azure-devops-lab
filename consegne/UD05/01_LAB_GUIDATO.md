2. Verifico che le subnet siano contenute nella VNet e non si sovrappongano. 
Elemento	CIDR
VNet	     10.50.0.0/16
web	        10.50.10.0/24
data	     10.50.20.0/24

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

5. Nel NSG, con l'associazione alla subnet, ho applicato la baseline a tutte le NIC che verranno collegate, evitando configurazioni individuali incoerenti.
{
  "Nsg": "/subscriptions/<omitted>/resourceGroups/rg-cea-network-f3624c/providers/Microsoft.Network/networkSecurityGroups/LAB_NSG",
  "Prefix": "10.50.20.0/24"
}

6. Nel portale ho creato la NIC "nic-data-01" in LAB_RG e LAB_LOCATION. La NIC rappresenta il punto di collegamento di una futura VM:
{
  "PrivateIp": "10.50.20.4",
  "PublicIp": null,
  "Subnet": "/subscriptions/<omitted>/resourceGroups/rg-cea-network-f3624c/providers/Microsoft.Network/virtualNetworks/vnet-cea-f3624c/subnets/snet-data"
}

7. Ho creato la NIC successiva da CLI
{
  "PrivateIp": "10.50.10.4",
  "PublicIp": null,
  "Subnet": "/subscriptions/<omitted>/resourceGroups/rg-cea-network-f3624c/providers/Microsoft.Network/virtualNetworks/vnet-cea-f3624c/subnets/snet-web"
}

8. 
È stata verificata la configurazione della NIC "nic-data-01", associata alla subnet "snet-data" della VNet. La subnet utilizza il prefisso "10.50.20.0/24" e risulta nello stato "Succeeded".
È stata eseguita la verifica dell'NSG effettivo associato alla NIC tramite:

```bash
az network nic list-effective-nsg \
  --resource-group "$LAB_RG" \
  --name nic-data-01 \
  --output jsonc
```
La verifica delle route effettive tramite "az network nic show-effective-route-table" non è stata completata perché la NIC non è associata a una VM in esecuzione. Questa condizione è coerente con il laboratorio, che in questa fase non prevede ancora una VM collegata alla NIC.

9. 
In questa fase è stato introdotto volontariamente un guasto di priorità. È stata aggiunta la regola Deny-Web-Postgres con priorità 200, che viene valutata prima della regola Allow-Web-Postgres con priorità 300. Poiché entrambe le regole interessano il traffico TCP proveniente da 10.50.10.0/24 verso la porta 5432, la regola di deny prevale e il flusso viene bloccato.

- Configurazione prima della correzione:

Priority    Name                Access    Source         Port
----------  ------------------  --------  -------------  ------
200         Deny-Web-Postgres   Deny      10.50.10.0/24  5432
300         Allow-Web-Postgres  Allow     10.50.10.0/24  5432

Successivamente il guasto è stato corretto eliminando la regola Deny-Web-Postgres.

- Verifica dopo l'eliminazione:

Priority    Name                Access    Source         Port
----------  ------------------  --------  -------------  ------
300         Allow-Web-Postgres  Allow     10.50.10.0/24  5432

Questa versione è migliore perché non dichiara di aver verificato la connettività reale: documenta soltanto la configurazione e il comportamento determinato dalle regole NSG.

10. Flusso analizzato: 10.50.10.0/24:any → 10.50.20.0/24:5432 TCP.

Il flusso rappresenta il traffico TCP proveniente dalla subnet 10.50.10.0/24, da qualsiasi porta sorgente, verso la porta 5432 della subnet 10.50.20.0/24. Sono state verificate la configurazione della rete e le regole NSG effettive. In questa UD non è stata verificata la connettività applicativa, poiché non è ancora presente una VM associata a una sorgente reale. La verifica della connettività tramite IP Flow Verify o connessione applicativa sarà possibile nella UD06.