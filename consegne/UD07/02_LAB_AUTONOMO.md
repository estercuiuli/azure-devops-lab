1. Creo lo script e il nuovo resoruce group 
Stato finale:
Name          Location    State
------------  ----------  ---------
rg-ud07-auto  italynorth  Succeeded

2. Controllo sulla Cloud Shell
ResourceGroupName Location   ProvisioningState Tags
----------------- --------   ----------------- ----
rg-ud07-auto      italynorth Succeeded         {[State, Verified], [ManagedBy, PowerShell], [UD, 07]}

3. Resource: /subscriptions/<omitted>/rg-ud07-auto
Operation name: Write tags
Time stamp: Tue Sep 15 2026 15:05:47 GMT+0200 (Ora legale dell’Europa centrale)
Event initiated by: email

4. 
The query returns:
Status      Requests   AvgDuration
WARN	    2	       470
OK	        2	       150

- produce 2 righe aggregate
- WARN, con latenza media di 470 ms
- summarize cambia la granularità perché raggruppa le righe per Status e restituisce un risultato aggregato per ogni gruppo, invece di mantenere le singole righe originali.

5. Metric                 Unit          Primary
---------------------  ------------  ---------
UsedCapacity           Bytes         Average
Transactions           Count         Total
Ingress                Bytes         Total
Egress                 Bytes         Total
SuccessServerLatency   MilliSeconds  Average
SuccessE2ELatency      MilliSeconds  Average
Availability           Percent       Average
ReplicationLagSeconds  Seconds       Average
MigrationProgress      Percent       Average

Timestamp             Name
--------------------  -------------
2026-09-15T12:24:00Z  Used capacity
Ho scelto la metrica UsedCapacity, espressa in Bytes, con aggregazione primaria Average. La metrica è stata interrogata tramite Azure CLI, ma non sono disponibili dati nel periodo analizzato. Non sono state modificate le metriche per tentativi.

6. AutoMitigate    Description    Enabled    EvaluationFrequency    Location    Name                             ResourceGroup    Severity    TargetResourceRegion    TargetResourceType                 WindowSize
--------------  -------------  ---------  ---------------------  ----------  -------------------------------  ---------------  ----------  ----------------------  ---------------------------------  ------------
True                           True       PT5M                   global      alert-ud07-storage-transactions  rg-ud07-monitor  3           italynorth              Microsoft.Storage/storageAccounts  PT5M

{
  "Actions": [],
  "Condition": {
    "allOf": [
      {
        "alertSensitivity": "Low",
        "criterionType": "DynamicThresholdCriterion",
        "failingPeriods": {
          "minFailingPeriodsToAlert": 4.0,
          "numberOfEvaluationPeriods": 4.0
        },
        "metricName": "Transactions",
        "metricNamespace": "Microsoft.Storage/storageAccounts",
        "name": "Metric1",
        "operator": "GreaterThan",
        "skipMetricValidation": false,
        "timeAggregation": "Total"
      }
    ],
    "odata.type": "Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria"
  },
  "Frequency": "PT5M",
  "Scope": "/subscriptions/<omitted>,
  "Severity": 3
}

La configurazione di alert rule indica cosa Azure deve controllare, mentre fired indica che la condizione dell'alert è stata effettivamente raggiunta.

7. sintomo: resource group non esistente
tipo di errore: ResourceGroupNotFound
ipotesi: rg non creato o nome errato
controllo: az group exists --name
correzione: az group create
verifica: az group exists --name deve dare true

8. 
# RUNBOOK — Risorsa Azure non trovata o contesto errato

# 1. Sintomo

Una risorsa Azure non viene trovata oppure un comando restituisce un errore come:

```text
ResourceNotFound
ResourceGroupNotFound
```

Prima di modificare o ricreare risorse, verificare il contesto e i nomi utilizzati.


# 2. Controllo account/subscription

Verificare l'account Azure autenticato:

```bash
az account show --output table
```

Controllare la subscription attualmente selezionata:

```bash
az account show \
  --query "{Name:name,SubscriptionId:id}" \
  --output table
```

Se necessario, elencare le subscription disponibili:

```bash
az account list --output table
```

e selezionare quella corretta:

```bash
az account set --subscription "<SUBSCRIPTION_ID>"
```

---

# 3. Controllo nome Resource Group

Verificare che il Resource Group esista:

```bash
az group exists --name "$LAB_RG"
```

Se restituisce:

```text
true
```

il Resource Group esiste.

Per visualizzarne i dettagli:

```bash
az group show \
  --name "$LAB_RG" \
  --output table
```

È importante verificare anche che il nome sia scritto correttamente.

# 4. Controllo Resource ID / nome

Verificare che il nome della risorsa sia corretto e che appartenga al Resource Group previsto.

Per esempio, per uno Storage Account:

```bash
az storage account show \
  --resource-group "$LAB_RG" \
  --name "$STG" \
  --output table
```

Per ottenere il Resource ID:

```bash
az storage account show \
  --resource-group "$LAB_RG" \
  --name "$STG" \
  --query id \
  --output tsv
```

Controllare che Resource Group, nome e Resource ID facciano riferimento alla stessa risorsa.

# 5. Activity Log

Se la risorsa o un'operazione presenta un comportamento inatteso, consultare l'Activity Log:

```bash
az monitor activity-log list \
  --resource-group "$LAB_RG" \
  --offset 1h \
  --max-events 10 \
  --output table
```

Se si conosce il Resource ID:

```bash
az monitor activity-log list \
  --resource-id "$RESOURCE_ID" \
  --offset 1h \
  --max-events 10 \
  --output table
```

# 6. Interpretazione

Interpretare le evidenze raccolte prima di effettuare modifiche.

Esempi:

* ResourceGroupNotFound: il Resource Group non esiste oppure il nome è errato.
* ResourceNotFound: la risorsa non esiste nel contesto specificato oppure il nome/ID è errato.
* Succeeded: nell'Activity Log: l'operazione è stata completata con successo.
* Failed: l'operazione non è stata completata.
* Resource Group corretto ma risorsa assente → verificare nome e Resource ID.
* Subscription errata: i comandi possono cercare la risorsa nel contesto sbagliato.

La presenza di un evento nell'Activity Log dimostra che un'operazione è stata registrata, ma non dimostra automaticamente la causalità di eventuali altri cambiamenti osservati.

# 7. Correzione minima

Applicare soltanto la modifica necessaria in base alla causa individuata.

Esempi:

Se il Resource Group non esiste:

```bash
az group create \
  --name "$LAB_RG" \
  --location "$LAB_LOCATION"
```

Se la subscription è errata:

```bash
az account set --subscription "<SUBSCRIPTION_ID>"
```

Se il problema è un nome errato, correggere il nome utilizzato nel comando senza ricreare la risorsa.

Non ricreare una risorsa prima di aver verificato che non esista già.


# 8. Verifica finale

Ripetere il controllo che aveva evidenziato il problema.

Per un Resource Group:

```bash
az group exists --name "$LAB_RG"
```

Per una risorsa:

```bash
az storage account show \
  --resource-group "$LAB_RG" \
  --name "$STG" \
  --output table
```

La verifica deve confermare che la risorsa sia presente e accessibile nel contesto corretto.

# 9. Cleanup

Al termine del laboratorio, eliminare le risorse create se non sono più necessarie.

Per eliminare l'intero Resource Group:

```bash
az group delete \
  --name "$LAB_RG" \
  --yes
```

Verificare successivamente:

```bash
az group exists --name "$LAB_RG"
```

Il risultato atteso è:

```text
false
```

Il cleanup evita di lasciare risorse attive e di generare costi non necessari.
