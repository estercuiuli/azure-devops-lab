1. Perché Azure Blob e Azure Files non sono intercambiabili?
Perché utilizzano modelli di accesso diversi.
Blob Storage → memorizza dati come oggetti organizzati in container; è adatto a immagini, documenti, backup, log, ecc.
Azure Files → offre vere e proprie file share, accessibili tramite protocolli come SMB/NFS, quindi è adatto quando applicazioni o utenti devono lavorare con una struttura di file e directory.
Blob = object storage. Files = file system condiviso.

2. Qual è la differenza tra management plane e data plane?
Il management plane riguarda la gestione della risorsa Azure.
Il data plane riguarda invece i dati contenuti nella risorsa.

3. Perché Contributor sullo storage account non implica accesso Blob con Entra ID?
Perché Azure RBAC del management plane e autorizzazione del data plane sono distinte.
Il ruolo Contributor permette di gestire la risorsa Storage Account, ma non concede automaticamente i permessi per accedere ai dati Blob tramite Microsoft Entra ID.

4. Perché geo-ridondanza e backup risolvono problemi diversi?
La geo-ridondanza mantiene una copia dei dati in un'altra regione per aumentare la disponibilità e la resilienza in caso di problemi geografici.
Il backup serve invece a poter recuperare i dati da una situazione precedente, ad esempio dopo una cancellazione o una modifica accidentale.
Il punto fondamentale è:
Se elimino un dato, la cancellazione può essere replicata anche nella copia geografica. Quindi la geo-ridondanza non sostituisce il backup.

5. Quali fattori valuteresti prima di scegliere Archive?
Valuterei:
frequenza di accesso ai dati;
tempo massimo accettabile per recuperarli;
costi di recupero;
durata prevista della conservazione;
eventuali periodi minimi di permanenza.
Archive è adatto a dati raramente utilizzati, per cui posso aspettare il recupero.
Non scelgo Archive semplicemente perché il file è vecchio: valuto quanto spesso e quanto rapidamente dovrò recuperarlo.

6. Perché una account key ha un impatto maggiore di una SAS limitata?
Perché una account key concede un accesso molto ampio allo Storage Account a chi la possiede.
Una SAS, invece, può essere limitata a:
determinate operazioni;
determinate risorse;
un determinato periodo.
Quindi se una SAS permette soltanto di leggere un determinato Blob per un'ora, il rischio è molto più limitato rispetto alla compromissione di una account key.

7. Quali proprietà rendono una SAS coerente con il minimo privilegio?
Una SAS dovrebbe avere:
permessi minimi + risorsa più specifica possibile + durata più breve possibile + HTTPS.

Per esempio, se devo solo permettere la lettura di un Blob:
-non concedo lettura/scrittura/eliminazione sull'intero account per 30 giorni.
-concedo solo lettura, sullo specifico Blob, per il tempo strettamente necessario.

8. Perché non possiamo verificare una policy lifecycle aspettando pochi minuti?
Perché una policy lifecycle management non viene necessariamente applicata immediatamente.
Azure deve elaborare la policy e individuare i Blob che soddisfano le condizioni. L'elaborazione può quindi richiedere ore, non semplicemente pochi minuti.