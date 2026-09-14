1. Una VM Azure comprende la risorsa di calcolo, i dischi, una NIC per la connettività di rete e, a seconda dello scenario, un Public IP e regole NSG. La VM fornisce CPU e RAM, i dischi forniscono lo storage, la NIC collega la VM alla VNet e gli NSG controllano il traffico.

2. Un Public IP non garantisce la raggiungibilità perché devono essere corretti anche routing, regole NSG/firewall, porta e servizio in ascolto sulla VM.

3. Le availability Zone sono zone fisicamente separate all'interno di una stessa Azure Region.
Servono soprattutto a proteggere da un problema che colpisce una singola zona.
Availability Set distribuisce le VM in modo da ridurre l'impatto di guasti o manutenzioni all'interno della stessa region.
Un VM Scale Set (VMSS) permette di gestire un insieme di VM come un gruppo e di modificarne il numero in base alle necessità.

4. Scale up serve ad aumentare la potenza della VM, cioè per rendere più potente la singola macchina.
Scale out invece aumenta il numero di VM, cioè
il numero di istanze.

5. Azure Monitor Autoscale può modificare dinamicamente il numero di istanze di un VM Scale Set in base a metriche come la CPU. Le soglie stabiliscono quando effettuare lo scaling, mentre i valori minimo e massimo limitano il numero di istanze e impediscono una scalabilità eccessiva o insufficiente.

6. App Service Plan definisce le risorse e il livello di hosting disponibili per le applicazioni:
CPU
memoria
pricing tier
capacità di scaling

Web App è la singola applicazione web che viene eseguita all'interno dell'App Service Plan.

7. Azure Monitor Autoscale può applicare regole di autoscaling a risorse supportate, ad esempio un VM Scale Set, e ragiona su metriche e regole.
App Service Automatic Scaling è il meccanismo di scaling specifico di Azure App Service.
Permette di scalare automaticamente le Web App in base alla configurazione e al piano App Service.

8. Metrics: sono valori numerici misurati nel tempo. Sono ottime per:
dashboard
grafici
alert
autoscaling
Logs: sono informazioni più dettagliate sugli eventi e sul comportamento del sistema.
Log Analytics permette di raccogliere e interrogare questi dati usando query, tipicamente con KQL (Kusto Query Language).

9. Il Recovery Services vault è il contenitore utilizzato per gestire i backup. La backup policy definisce frequenza e conservazione dei backup, mentre un recovery point rappresenta uno specifico stato recuperabile generato dal backup.

10. 
High Availability
Obiettivo:
Il servizio deve continuare a funzionare anche se qualcosa si guasta. Gli utenti possono continuare a utilizzare il servizio.

Backup
Obiettivo:
Poter recuperare dati/stato precedente.
Per esempio un file viene cancellato accidentalmente.

Disaster Recovery (DR)
Obiettivo:
Ripristinare il servizio dopo un evento grave che compromette l'ambiente principale.

11. 
RPO — Recovery Point Objective
Risponde a:
"Quanti dati posso permettermi di perdere?"
Esempio: 1 ora
Significa che, in caso di incidente, l'organizzazione accetta potenzialmente di perdere fino a circa 1 ora di dati, a seconda della soluzione adottata.

RTO-Recovery Time Objective
Risponde a:
"Quanto tempo posso permettermi che il servizio rimanga indisponibile?"
Esempio: 30 minuti
Significa che il servizio deve essere ripristinato entro circa 30 minuti.

12. Quando una VM viene deallocated, Azure interrompe la fatturazione del compute della VM, ma le risorse associate possono continuare a generare costi.