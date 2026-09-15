1. A
2. B
3. A
4. A
5. B
6. B
7. B
8. B

9. Distingui Activity Log, Metrics e Logs.

Activity Log: registra principalmente le operazioni e gli eventi del control plane di Azure.
Metrics: sono valori numerici misurati nel tempo, come CPU, latenza o capacità.
Logs: contengono record dettagliati di eventi e dati diagnostici, interrogabili con KQL.

10. Spiega l'idempotenza con un esempio amministrativo.

Una procedura è idempotente quando può essere eseguita più volte ottenendo lo stesso stato finale senza effetti indesiderati. Ad esempio, uno script controlla se un Resource Group esiste e lo crea solo se non esiste; se esiste, lo riutilizza.

11. Distingui table e tsv.

table produce un output organizzato in colonne e leggibile dall'utente.
tsv produce valori separati da tabulazioni ed è particolarmente utile negli script Bash e per assegnare valori a variabili.

12. Spiega perché Log Analytics workspace e diagnostic setting non sono la stessa cosa.

Il Log Analytics workspace è la destinazione in cui vengono raccolti e analizzati i dati di log.
La diagnostic setting configura quali log e metriche raccogliere e verso quale destinazione inviarli.

13. Distingui Alert Rule e Action Group.

L'Alert Rule definisce la condizione che determina quando deve scattare un alert.
L'Action Group definisce le notifiche e le azioni da eseguire quando l'alert scatta.

14. Perché correlazione temporale non implica causalità?

Perché il fatto che due eventi avvengano in momenti vicini dimostra una relazione temporale, ma non dimostra che il primo evento abbia causato il secondo. Potrebbero esserci altre cause o fattori intervenienti.

15. Quali fatti puoi affermare con certezza?

Alle 10:15 la risorsa è stata modificata.
Alle 10:16 l'Activity Log ha registrato una write con esito Succeeded.
Alle 10:20 la metrica è aumentata.
Alle 10:25 l'alert è passato a Fired.

Questi eventi sono quindi osservati e documentati, ma non è ancora dimostrato un rapporto di causa-effetto tra loro.

16. Quale ulteriore analisi è necessaria prima di affermare che la modifica delle 10:15 ha causato l'alert?

È necessario analizzare l'andamento della metrica e la condizione dell'alert, verificare la finestra temporale e confrontare gli eventi nei log. Bisogna inoltre escludere altre possibili cause del cambiamento della metrica e verificare che la modifica delle 10:15 sia effettivamente compatibile con la condizione che ha fatto scattare l'alert.