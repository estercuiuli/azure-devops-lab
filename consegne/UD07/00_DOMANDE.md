1. Perché --query è preferibile a cercare manualmente una stringa nell'output JSON?
Perché permette di estrarre direttamente i campi necessari in modo preciso, leggibile e facilmente automatizzabile, evitando di cercare manualmente le informazioni nell'intero output JSON.

2. Qual è la differenza tra table e tsv in Azure CLI? 
table produce un output organizzato in colonne e leggibile dall'utente, mentre tsv produce valori separati da tabulazioni ed è più adatto all'utilizzo negli script.

3. Che cosa significa lavorare con oggetti in PowerShell?
Significa lavorare con dati strutturati che possiedono proprietà e metodi, invece di trattare l'output principalmente come testo.

4. Che cosa significa che una procedura amministrativa è idempotente?
Significa che può essere eseguita più volte ottenendo lo stesso stato finale desiderato, senza creare duplicazioni o effetti indesiderati.

5. Distingui Activity Log, Metrics e Logs.
Activity Log registra le operazioni e gli eventi del control plane di Azure; Metrics rappresentano valori numerici nel tempo, come CPU, latenza o capacità; Logs contengono record dettagliati di eventi e dati diagnostici, interrogabili con KQL.

6. A che cosa serve un Log Analytics workspace?
Serve a raccogliere, centralizzare e analizzare dati di log provenienti da diverse risorse e servizi, utilizzando principalmente KQL.

7. A che cosa serve una diagnostic setting?
Serve a configurare quali log e metriche raccogliere da una risorsa e verso quale destinazione inviarli, ad esempio un Log Analytics workspace, uno Storage Account o un Event Hub.

8. Perché Activity Log e AzureActivity non sono esattamente la stessa cosa?
Activity Log è il servizio Azure che registra le attività del control plane, mentre AzureActivity è una tabella di Log Analytics che contiene gli Activity Log che sono stati raccolti nel workspace.

9. Distingui Alert Rule e Action Group.
L'Alert Rule definisce la condizione che determina quando un alert deve scattare; l'Action Group definisce le azioni da eseguire quando l'alert scatta, come l'invio di notifiche.

10. Perché un alert Fired non equivale automaticamente a un incidente?
Perché Fired significa che la condizione definita nella regola è stata soddisfatta, ma non implica necessariamente che ci sia un problema reale o un incidente. È necessario analizzare ulteriori evidenze.

11. Qual è la differenza tra correlazione e causalità?
La correlazione indica che due eventi sono associati o si verificano in relazione temporale; la causalità indica invece che un evento è effettivamente la causa dell'altro. La correlazione da sola non dimostra la causalità.

12. Quali sono i passaggi essenziali di un troubleshooting ripetibile?
Sintomo → Ipotesi → Controllo → Interpretazione → Correzione minima → Verifica finale → Cleanup
