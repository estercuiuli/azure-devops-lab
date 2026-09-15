1. Ho controllato login e account 

2. Preparo le varibili

3. Creo il resource group. Il risultato di ProvisioningState è Succeeded

4. Leggo lo script e lo eseguo. Inixialmente è comparso "Il Resource Group non esiste: lo creo."; rieseguendolo, dopo la creazione, è comparso "Il Resource Group esiste già: lo riutilizzo."

Lo script è più sicuro perché prima di creare il Resource Group verifica se esiste già. Se non esiste lo crea, mentre se esiste lo riutilizza. In questo modo evita di tentare inutilmente una nuova creazione della stessa risorsa e rende lo script riutilizzabile anche dopo una seconda esecuzione.

5. In questo punto abbiamo messo a confronto tre output relativi al resource group.
Con --query selezioniamo solo le proprietà più utili; con  tsv e json un unico valore;
Table lo preferiamo quando abbiamo bisogno di vedere tutte le caratteristiche più importanti del RG, mentre tsv quando ci serve solo un'informazione.

6. Adesso utilizzando la powershell del portale azure, abbiamo creato un resource group nuovo, utilizzando lo stesso principio di prima.
ResourceGroupName Location   ProvisioningState Tags
----------------- --------   ----------------- ----
rg-ud07-ps-test   westeurope Succeeded        

7. Ho provato a creare un Log Analytics Workspace con westeurope ma non da disponibilità regionale, perciò ho utilizzato northeurope con esito positivo.
Name            Location     State
--------------  -----------  ---------
law-ud07-32554  northeurope  Succeeded

8. Eseguiamo ora una query che permette di verificare autenticazione, workspace e motore KQL.
Course    Status    TableName      UD
--------  --------  -------------  ----
AZ-104    OK        PrimaryResult  7

In questo caso sono state raggruppate API e WEB sotto lo Status OK.
Count    Status    TableName
-------  --------  -------------
2        OK        PrimaryResult
1        WARN      PrimaryResult

9. Interroghiamo Activity Log:
Time                          Operation              Status
----------------------------  ---------------------  ---------
2026-09-15T12:13:19.4548798Z  Update resource group  Succeeded
2026-09-15T12:13:18.9392619Z  Update resource group  Started
2026-09-15T10:59:27.0151965Z  Create Workspace       Succeeded
2026-09-15T10:59:06.5398338Z  Create Workspace       Accepted
2026-09-15T10:59:06.0710797Z  Create Workspace       Started
2026-09-15T10:57:51.1002741Z  Create Workspace       Failed
2026-09-15T10:57:51.0221544Z  Create Workspace       Started
2026-09-15T10:54:18.7826678Z  Create Workspace       Failed
2026-09-15T10:54:18.7826678Z  'deny' Policy action.  Failed
2026-09-15T10:54:18.7514157Z  Create Workspace       Started

10. ho creato dal portale una nuova diagnostic setting "ud07-activity-to-law" con le categorie
Administrative
Policy
Alert
ServiceHealth
ResourceHealth
La verifica mostra che esiste una regola a livello subscription che punta al workspace.

Name                  Workspace
--------------------  ----------------------------------------------------------------------------------------------------------------------------------------------------
ud07-activity-to-law  /subscriptions/<omitted>-monitor/providers/Microsoft.OperationalInsights/workspaces/law-ud07-32554

11. AzureActivity non ancora popolata nel time range osservato.

12. adesso creiamo lo Storage Account nella stessa regione del workspace e recuperiamo il Resource ID. 

AccessTier    AllowBlobPublicAccess    CreationTime                      EnableHttpsTrafficOnly    Kind       Location    MinimumTlsVersion    Name            PrimaryLocation    ProvisioningState    ResourceGroup    StatusOfPrimary
------------  -----------------------  --------------------------------  ------------------------  ---------  ----------  -------------------  --------------  -----------------  -------------------  ---------------  -----------------
Hot           False                    2026-09-15T12:29:39.847699+00:00  True                      StorageV2  italynorth  TLS1_0               stud0789467014  italynorth         Succeeded            rg-ud07-monitor  available

13. Chiediamo ad Azure quali metriche sono definite per la risorsa:
Metric                 Unit          Primary
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
2026-09-15T11:37:00Z  Used capacity

14. Creiamo dal portale un Action Group:
Name     Enabled
-------  ---------
ag-ud07  True

15. Creiamo un Alert Group da portale:
Name                             Enabled    Severity
-------------------------------  ---------  ----------
alert-ud07-storage-transactions  True       3

enabled: indica se l'alert è abilitato e quindi può essere valutato.
- true = l'alert è attivo.
- false = l'alert è disabilitato e non genera nuove notifiche.
Fired: indica che le condizioni dell'alert si sono verificate e l'alert è stato attivato.

16. Modifichiamo lo storage account con state=Changed
Time                          Operation                      Status
----------------------------  -----------------------------  ---------
2026-09-15T12:30:00.1671671Z  Create/Update Storage Account  Succeeded
2026-09-15T12:29:42.4237343Z  Create/Update Storage Account  Accepted
2026-09-15T12:29:39.5172772Z  Create/Update Storage Account  Started
2026-09-15T12:28:56.3128605Z  'deny' Policy action.          Failed
2026-09-15T12:28:56.3128605Z  Create/Update Storage Account  Failed
2026-09-15T12:28:56.2972357Z  Create/Update Storage Account  Started

La presenza dell'evento prova causalità?

No. La presenza dell'evento nel log prova che l'operazione di modifica dello Storage Account è stata eseguita con successo e che Azure l'ha registrata. Tuttavia, non dimostra che un eventuale cambiamento di una metrica sia stato causato da quella modifica.
Per dimostrare la causalità sarebbe necessario correlare temporalmente l'evento con il cambiamento della metrica e avere ulteriori evidenze che escludano altre possibili cause.
