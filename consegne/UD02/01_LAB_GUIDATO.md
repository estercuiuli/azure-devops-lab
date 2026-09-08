/subscriptions/<omitted>/resourceGroups/LAB_RG/providers/Microsoft.Network/publicIPAddresses/labVnet-ip
/subscriptions/<omitted>/resourceGroups/LAB_RG/providers/Microsoft.Network/networkSecurityGroups/labVnet-nsg
/subscriptions/<omitted>/resourceGroups/LAB_RG/providers/Microsoft.Network/virtualNetworks/LAB_VNET
/subscriptions/<omitted>/resourceGroups/LAB_RG/providers/Microsoft.Network/networkInterfaces/labvnet921
/subscriptions/<omitted>/resourceGroups/LAB_RG/providers/Microsoft.Compute/virtualMachines/labVnet
/subscriptions/<omitted>/resourceGroups/LAB_RG/providers/Microsoft.Compute/disks/labVnet_OsDisk_1_af592eaf23bc473b863ec8c48540ffeb
/subscriptions/<omitted>/resourceGroups/LAB_RG/providers/Microsoft.Storage/storageAccounts/lbstrg

Nel portale, aprendo il Resource Group, ho potuto visualizzare direttamente le risorse presenti, distinguendone tipo, località, tag e stato di provisioning. Ad esempio, ho verificato che il Resource Group contenesse la VNet vnet-cea-ud02 e lo Storage Account, entrambi nella località scelta e con i tag del laboratorio.
Con la CLI ho eseguito invece az resource list e ho selezionato tramite --query solamente i campi di interesse, ottenendo un inventario più compatto e ripetibile. Ho inoltre potuto visualizzare gli ID delle risorse e anonimizzare la parte relativa alla subscription.
In questo laboratorio il portale è risultato più comodo per creare le risorse e per esplorarne visivamente le proprietà, mentre la CLI è stata più efficace per verificare sistematicamente le stesse proprietà e ottenere solo i campi necessari. In particolare, la CLI permette di ripetere lo stesso controllo senza dover navigare nuovamente tra le pagine del portale.