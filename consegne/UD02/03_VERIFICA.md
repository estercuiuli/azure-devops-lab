# Verifica — Modelli cloud e struttura iniziale di Azure

# Parte A 

1. B

2. C

3. C

4. B

5. B

6. C

7. B

8. C

# Parte B 

9. Cloud pubblico: infrastruttura fornita da un provider cloud e condivisa tra più clienti.
Cloud privato: infrastruttura dedicata a una singola organizzazione.
Cloud ibrido: combinazione di cloud pubblico e privato, ad esempio mantenendo alcuni dati in un ambiente privato e utilizzando Azure       per'applicazione.

10. Il tenant Microsoft Entra gestisce identità e utenti dell'organizzazione.
La sottoscrizione contiene le risorse Azure ed è anche un confine amministrativo e di fatturazione. 
Il resource group organizza logicamente le risorse. La risorsa è il servizio Azure effettivamente creato.
Tenant → Sottoscrizione → Resource Group → Risorsa

11. Una region è un'area geografica Azure che contiene uno o più datacenter. Una availability zone è una suddivisione fisicamente separata all'interno di una region, utilizzata per aumentare la resilienza.

12. Azure Portal permette di gestire le risorse tramite interfaccia grafica. Azure CLI permette di eseguire le operazioni tramite comandi, risultando utile per automazione e procedure ripetibili.

13. I tag del resource group non vengono automaticamente ereditati dalle risorse. Per poter identificare e gestire direttamente le singole risorse tramite tag, devono essere applicati anche alle risorse.

# Parte C 

1. Nell'ID sono riconoscibili:

   * Sottoscrizione: `<omitted>`
   * Resource group: `rg-cea-test`
   * Provider: `Microsoft.Storage`
   * Tipo: `storageAccounts`
   * Nome: `stceatest01`

2. La risorsa si trova in `italynorth` e presenta i tag:

   * `environment=lab`
   * `unit=UD02`

3. Per verificare l'appartenenza al resource group:

```bash
az storage account show \
  --resource-group "rg-cea-test" \
  --name "stceatest01" \
  --query "{Name:name,ResourceGroup:resourceGroup,Location:location}" \
  --output jsonc
```

Il risultato atteso deve mostrare `ResourceGroup` uguale a `rg-cea-test`.

4. Se il resource group contiene soltanto risorse del laboratorio:

```bash
az group delete \
  --name "rg-cea-test" \
  --yes \
  --no-wait
```

5. Dopo l'eliminazione:

```bash
az group exists \
  --name "rg-cea-test"
```

Risultato atteso:

```text
false
```
