1. Scelgo Blob perché il requisito è archiviare documenti come oggetti. Azure Files è più adatto a file share, Queue a messaggi asincroni e Table a dati NoSQL.

2. In produzione sceglierei ZRS se il requisito comprende la resilienza a un guasto zonale, perché replica i dati tra zone separate della stessa regione. Il laboratorio usa LRS per ridurre i costi, dato che i dati non richiedono alta resilienza.

3. 
Name     Lease Status    Last Modified
-------  --------------  -------------------------
archive  unlocked        2026-09-10T10:22:35+00:00

4. 
Name                   Tier    Size
---------------------  ------  ------
current/documento.txt  Hot     49

5. 
È stata generata una User Delegation SAS per il singolo Blob archive/current/documento.txt, con permesso di sola lettura (r) e durata massima di 15 minuti.
L'accesso al Blob tramite SAS è stato verificato con esito positivo.
Al termine della verifica, le variabili contenenti token, URL e scadenza sono state rimosse dalla sessione.
Per motivi di sicurezza, il token SAS e l'URL firmato non vengono riportati nel documento.

6. 
- AuthorizationPermissionMismatch
Causa: L'identità è autenticata ma non ha i permessi necessari sui dati Blob.
Controllo: Verificare i ruoli RBAC del data plane, ad esempio Storage Blob Data Reader/Contributor.

- ResourceNotFound: The specified container does not exist
Causa: Il container non esiste oppure il nome è errato.
Controllo: Verificare i container presenti con az storage container list.

- curl: (22) The requested URL returned error: 403
Causa: La richiesta è stata rifiutata, ad esempio per SAS non valida/scaduta, permessi insufficienti o accesso bloccato.
Controllo: Verificare SAS, permessi, scadenza e configurazione di accesso/rete.

7. 
Perché sono due percorsi diversi e la lifecycle rule usa il prefisso per selezionare i Blob.

8. 
Driver di costo
- capacità dei dati
- ridondanza
- tier
- operazioni
- recupero dati
- trasferimento dati

CLean up
- Eliminare eventuali SAS/token temporanei       
- Eliminare Blob temporanei      
- Eliminare container creati per il laboratorio     
- Eliminare eventuali ruoli/assegnazioni temporanee    
- Eliminare lo Storage Account se creato appositamente
- Verificare che non siano rimaste risorse