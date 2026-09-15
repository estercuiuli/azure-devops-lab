1. 2. Per iniziare ho controllato l'accesso al servizio azure e impostato le variabili.

3. Creo la VM dal portale, verificando la disponibilità delle regioni in base alla sottoscrizione e le relative dimensioni. Creata la VM ho ricevuto la chiave privata ssh.

4. Controlllo che la vm sia stata creata correttamente da CLI:
Power       Private     Public         Size
----------  ----------  -------------  ----------------
VM running  172.16.0.4  72.146.193.49  Standard_DC1s_v3
{
  "image": {
    "exactVersion": "24.04.202608270",
    "offer": "ubuntu-24_04-lts",
    "publisher": "canonical",
    "sku": "server",
    "version": "latest"
  },
  "nic": "/subscriptions/<omitted>",
  "osDisk": "vm-ud06-linux_OsDisk_1_f419f62a27074248b54d592f6138018e",
  "size": "Standard_DC1s_v3"
}

5. Ho configurato una regola di traffico in ingresso (Inbound Rule) nell’NSG associato alla VM per consentire l’accesso SSH. Ho autorizzato il protocollo TCP sulla porta 22, limitando la sorgente al mio indirizzo IP pubblico tramite l’opzione My IP address. Ho impostato la priorità a 300, applicando così il principio del minimo accesso necessario ed evitando di esporre la porta SSH a tutto Internet.

6. Successivamente ho recuperato tramite Azure CLI il Public IP della VM e si è tentato di stabilire una connessione SSH utilizzando la chiave privata associata alla VM.

Il primo tentativo non è andato a buon fine perché il percorso della chiave privata indicato (~/.ssh/ud06_azure) non esisteva nell'ambiente WSL. È stata quindi individuata la chiave privata presente nel sistema Windows e utilizzato il relativo percorso /mnt/c/Users/... accessibile da WSL.

Il secondo tentativo ha confermato che la VM era raggiungibile sulla porta 22, ma la chiave privata non veniva utilizzata perché il file aveva permessi troppo permissivi (0777). Per risolvere il problema, la chiave è stata copiata nella directory .ssh dell'ambiente Linux e sono stati impostati i permessi 600, necessari per permettere a SSH di utilizzare la chiave in sicurezza.

7. Dopo essere entrata dentro la VM, ho installato Nginx

HTTP/1.1 200 OK
Server: nginx/1.24.0 (Ubuntu)
Date: Mon, 14 Sep 2026 13:00:57 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Mon, 14 Sep 2026 12:59:25 GMT
Connection: keep-alive
ETag: "6aa7efad-267"
Accept-Ranges: bytes

8. È stata verificata la raggiungibilità del servizio web della macchina virtuale tramite il suo Public IP, utilizzando il comando curl -I "http://$LAB_VM_IP". La VM ha risposto con codice HTTP 200 OK, confermando che il traffico HTTP sulla porta 80 è consentito e che il web server Nginx è correttamente attivo e raggiungibile dall’esterno.
HTTP/1.1 200 OK
Server: nginx/1.24.0 (Ubuntu)
Date: Mon, 14 Sep 2026 13:11:23 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Mon, 14 Sep 2026 12:59:25 GMT
Connection: keep-alive
ETag: "6aa7efad-267"
Accept-Ranges: bytes

9. È stato utilizzato lo strumento IP Flow Verify di Network Watcher per simulare una connessione TCP in ingresso dalla rete del client verso la porta 80 della VM. Dopo aver impostato l'indirizzo IP pubblico del client (79.13.26.78), il flusso è stato verificato rispetto alla regola Allow-HTTP-MyIP.
Results
Access allowed
Allow-HTTP-MyIP

10. in questa fase sono state analizzate le metriche relative a:
Percentage CPU
Network In
Network Out
e successivamente sono stati cambiati i valori di:
time range=30 min
aggregation=max
metrica=Available Memory Byte

11. 
min: 1
default: 1
max: 3
metrica: Percentage CPU
soglia: >70 per una media di 5 min
azione: scale out di 1 istanza

Perché impostare un massimo? 
Per evitare una crescita incontrollata del numero di istanze, che potrebbe comportare costi elevati e uno scaling eccessivo in caso di picchi o anomalie.

12. Ho effettuato delle verifiche per creare una Web App e sono risultate negative.

14. APP_SERVICE_LIVE=no
    scale out → aumento il numero di istanze
    scale in → diminuisco il numero di istanze

 #  Modalità	                    Basata su
    Manual	                        Numero di istanze impostato manualmente dall'operatore
    Azure Monitor Autoscale	        Regole + metriche, ad esempio CPU, che determinano scale out/scale in
    Automatic Scaling	            Scaling gestito automaticamente dal servizio in base al carico e alla configurazione del servizio

15. App Service Metrics non eseguite: piano Free non disponibile

16. Dal portale ho osservato il percorso:
Virtual machine→ Backup

Dopodichè ho Identificato:
Recovery Services vault
Backup policy
Schedule
Retention
Recovery point
Backup now

frequenza: ogni 4 ore
orario: 8 a.m.
retention: 30 giorni
Motivazione: garantire il recupero dei dati in caso di cancellazione accidentale, errore o guasto, mantenendo disponibili più punti di ripristino.

17. A: high availability
    B: Backup
    C: Disaster Recovery

18. 
Replication : copia dei dati/sistemi da una risorsa principale a una risorsa secondaria, per avere una replica pronta in caso di guasto. 

Failover : passaggio dal sistema principale a quello secondario quando il principale non è disponibile.

Failback: ritorno dal sistema secondario a quello principale dopo che il problema è stato risolto.

RPO (Recovery Point Objective): quantità massima di dati che si è disposti a perdere, espressa come intervallo di tempo.

RTO (Recovery Time Objective): tempo massimo accettabile per ripristinare il servizio dopo un guasto.