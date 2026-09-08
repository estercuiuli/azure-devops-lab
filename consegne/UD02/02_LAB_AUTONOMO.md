# Laboratorio autonomo — Ambiente Azure verificabile

## Scenario

È stato realizzato un ambiente Azure autonomo e separato dal laboratorio guidato, utilizzando un Resource Group dedicato. La località è stata recuperata dalle variabili del laboratorio e sono stati utilizzati nomi con un suffisso univoco.

## Risorse create

* Resource Group: `rg-cea-ud02-auto-0abe86c3`
* Location: `italynorth`
* VNet: `vnet-cea-auto`
* Address space VNet: `10.30.0.0/16`
* Subnet: `snet-workload`
* Prefix subnet: `10.30.10.0/24`
* Storage Account: `stceaauto0abe86c3`
* Storage Account kind: `StorageV2`
* SKU: `Standard_LRS`

Sono stati applicati alle risorse i tag richiesti:

* `course=cloud-engineer-academy`
* `unit=UD02`
* `environment=dev`
* `scenario=autonomous`
* `deleteAfter=2026-09-10`

## Verifica Resource Group

Comando utilizzato:

```bash
az group show \
  --name "$AUTO_RG" \
  --query "{Name:name,Location:location,State:properties.provisioningState,Tags:tags}" \
  --output jsonc
```

Output rilevante:

```text
Name: rg-cea-ud02-auto-0abe86c3
Location: italynorth
State: Succeeded
```

La verifica conferma che il Resource Group si trova nella località prevista ed è stato creato correttamente.

## Verifica VNet e subnet

Comando utilizzato:

```bash
az network vnet show \
  --resource-group "$AUTO_RG" \
  --name "$AUTO_VNET" \
  --query "{Name:name,Location:location,Address:addressSpace.addressPrefixes,Subnets:subnets[].{Name:name,Prefix:addressPrefix},Tags:tags}" \
  --output jsonc
```

Output rilevante:

```text
Name: vnet-cea-auto
Location: italynorth
Address: 10.30.0.0/16
Subnet: snet-workload
Prefix: 10.30.10.0/24
```

La verifica conferma che la VNet utilizza il prefisso richiesto e contiene la subnet `snet-workload` con il prefisso `10.30.10.0/24`.

## Verifica Storage Account

Comando utilizzato:

```bash
az storage account show \
  --resource-group "$AUTO_RG" \
  --name "$AUTO_STORAGE" \
  --query "{Name:name,Location:location,Kind:kind,Sku:sku.name,HttpsOnly:enableHttpsTrafficOnly,MinimumTls:minimumTlsVersion,PublicBlobAccess:allowBlobPublicAccess,State:provisioningState,Tags:tags}" \
  --output jsonc
```

Output rilevante:

```text
Name: stceaauto0abe86c3
Location: italynorth
Kind: StorageV2
Sku: Standard_LRS
HttpsOnly: true
MinimumTls: TLS1_2
PublicBlobAccess: false
State: Succeeded
```

La verifica conferma che lo Storage Account utilizza `StorageV2` e `Standard_LRS`, richiede HTTPS, utilizza TLS 1.2 come versione minima e non consente l'accesso pubblico ai Blob.

## Inventario delle risorse

Comando utilizzato:

```bash
az resource list \
  --resource-group "$AUTO_RG" \
  --query "[].{Name:name,Type:type,Location:location,Unit:tags.unit,Scenario:tags.scenario,DeleteAfter:tags.deleteAfter}" \
  --output table
```

Output:

```text
Name               Type                               Location    Unit    Scenario    DeleteAfter
-----------------  ---------------------------------  ----------  ------  ----------  -------------
vnet-cea-auto      Microsoft.Network/virtualNetworks  italynorth  UD02    autonomous  2026-09-10
stceaauto0abe86c3  Microsoft.Storage/storageAccounts  italynorth  UD02    autonomous  2026-09-10
```

L'inventario conferma che la VNet e lo Storage Account appartengono allo stesso Resource Group e si trovano nella stessa località.

Il risultato è stato confrontato con il Resource Group visualizzato nel Portale Azure, verificando la corrispondenza delle risorse. Nel Portale è stata inoltre verificata la presenza della subnet e le impostazioni di sicurezza dello Storage Account.

## Verifica dei requisiti

L'ambiente realizzato soddisfa i requisiti richiesti:

* Resource Group nella località prevista;
* VNet e Storage Account appartenenti allo stesso Resource Group;
* VNet con address space `10.30.0.0/16`;
* subnet `snet-workload` con prefisso `10.30.10.0/24`;
* Storage Account di tipo `StorageV2`;
* SKU `Standard_LRS`;
* HTTPS obbligatorio;
* TLS minimo 1.2;
* accesso pubblico ai Blob disabilitato;
* tag presenti sulle risorse;
* inventario ottenuto tramite Azure CLI coerente con quello verificato dal Portale Azure.

Gli eventuali identificativi completi delle risorse non vengono riportati nella relazione, in modo da mantenere gli ID anonimizzati.

## Cleanup

Al termine delle verifiche, l'ambiente autonomo viene eliminato tramite il Resource Group dedicato. La verifica finale deve confermare che il Resource Group non esista più.
