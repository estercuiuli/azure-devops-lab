1. stato VM=OK
Nginx=nginx/1.24.0 (Ubuntu)
esito HTTP=HTTP/1.1 200 OK
regola NSG che consente il traffico=Allow-HTTP-MyIP

2. é stato creato un guasto controllato con le seguenti impostazioni:
Name: Deny-HTTP-Auto
Priority: 200
Direction: Inbound
Protocol: TCP
Source: My IP
Destination port: 80
Action: Deny

3. sintomo: HTTP dall'esterno non raggiungibile

ipotesi: una regola NSG sta bloccando il traffico TCP/80

controllo: elenco NSG + IP Flow Verify + stato Nginx + curl localhost

causa: Deny-HTTP-Auto (priority 200) viene valutata prima di
  Allow-HTTP-MyIP (priority 310)

correzione minima: eliminare/disabilitare Deny-HTTP-Auto oppure assegnarle una priorità inferiore a quella dell'Allow

Results
Access denied
Deny-HTTP-Auto

4. Elimino la regola per risolvere il problema:
Results
Access allowed
Allow-HTTP-MyIP

5. metrica: Network In Total
intervallo: 2.6 MiB
aggregazione: avg
ciò che puoi dedurre: quanto e come cambia una risorsa.
ciò che NON puoi dedurre: la causa

6. 
min: 1
default: 1
max:4
metrica:
condizione: Average Percentage CPU >70 5m
azione: scale out 1 

7. A: scale up
   B: azure monitor autoscale
   C: automatic scaling
   D: scale out manuale

8. 
frequenza: ogni giorno
orario: 8 a.m.
retention: ogni 30 giorni
motivazione: evitare la perdita di dati importanti

9. 
A: HA. C'è un guasto a una singola istanza, ma il servizio deve continuare a essere disponibile. L'obiettivo è quindi garantire alta disponibilità tramite altre istanze/ridondanza.

B: B. La cancellazione accidentale richiede di recuperare una versione precedente dei dati. Il backup permette di effettuare il ripristino da un precedente punto di recupero.

C: DR. La regione primaria è indisponibile, quindi bisogna ripristinare il workload in un'altra regione. Questo è un caso di Disaster Recovery.

10. 
RPO: perdita massima dati 15 minuti
RTO: servizio nuovamente operativo entro 60 minuti