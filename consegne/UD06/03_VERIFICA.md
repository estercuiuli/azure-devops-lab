1. A
2. B
3. B
4. A
5. B
6. B
7. A
8. B

9. Availability Zone, Availability Set e VM Scale Set

Availability Zone: separa le risorse in zone fisicamente distinte all'interno della stessa regione, proteggendo da guasti a livello di zona.

Availability Set: distribuisce le VM tra fault domain e update domain, riducendo il rischio che un singolo guasto o aggiornamento renda indisponibili tutte le VM.

VM Scale Set: gestisce un insieme di VM come gruppo e permette di aumentare o diminuire automaticamente il numero di istanze.

10. 
Scale up: aumentare le risorse di una singola istanza, per esempio più CPU o RAM.

Scale out: aumentare il numero di istanze.

11. 
App Service Autoscale / Azure Monitor Autoscale: lo scaling viene effettuato sulla base di regole definite dall'utente e metriche.

Automatic Scaling: la piattaforma gestisce automaticamente lo scaling sulla base del traffico HTTP, senza richiedere necessariamente regole metriche esplicite.

12. 
High Availability (HA): garantisce che il servizio continui a essere disponibile anche in caso di guasto di una componente.

Backup: permette di recuperare dati o uno stato precedente.

Disaster Recovery (DR): permette di ripristinare il servizio dopo un evento grave, eventualmente in un'altra regione.

13. 
Recovery Services vault: contenitore Azure che centralizza e gestisce dati/configurazioni relativi a backup e recovery.

Backup policy: definisce quando vengono effettuati i backup e per quanto tempo vengono conservati.

Recovery point: è uno specifico punto temporale recuperabile, cioè uno stato del dato/sistema da cui è possibile effettuare un ripristino.

14. 
RPO (Recovery Point Objective): quantità massima di dati che si accetta di perdere, espressa come intervallo temporale.

RTO (Recovery Time Objective): tempo massimo accettabile per ripristinare il servizio.

15. La causa più probabile è Deny-HTTP, perché ha priorità 100, quindi viene valutata prima di Allow-HTTP con priorità 300 e blocca il traffico TCP sulla porta 80.

16. La correzione minima è rimuovere/disabilitare Deny-HTTP oppure modificarla in modo che non blocchi quella richiesta.

Poi farei queste verifiche:

- Controllo NSG: Verifico che Allow-HTTP sia attiva e consenta TCP/80 dal mio IP.

- IP Flow Verify: deve dare access allowed

- Stato Nginx: deve essere active (running).

- Test locale: deve restituire HTTP/1.1 200 OK

- Test esterno: deve restituire HTTP/1.1 200 OK