1. Sono state inizialmente ricostruite VNet,subnet,prefissi,NIC e associazioni usando portale e CLI
2. Aggiungo temporaneamente una regola "Deny-Web-Postgres-Auto" con priorità 250:
Priority    Name                    Access    Source         Port
----------  ----------------------  --------  -------------  ------
250         Deny-Web-Postgres-Auto  Deny      10.50.10.0/24  5432
300         Allow-Web-Postgres      Allow     10.50.10.0/24  5432
3. Si può notare dalla stampa precedente che la nuova regola "Deny-Web-Postgres-Auto", con priorità numerica 250, viene valutata prima della regola Allow-Web-Postgres, con priorità 300.
4. L'NSG LAB_NSG risulta associato alla subnet snet-data. La NIC nic-data-01, appartenendo a tale subnet, è soggetta alle regole dell'NSG associato alla subnet.
La verifica delle route effettive tramite NIC non è stata possibile poiché la NIC non è associata a una VM in esecuzione. In questa UD è stata quindi verificata la configurazione della rete e dell'associazione delle regole NSG alla subnet, non la connettività applicativa.
Subnet     NSG
---------  --------------------------------------------------------------------------------------------------------------------------------------------------
snet-data  /subscriptions/<omitted>/LAB_NSG
5. L'assenza della VM impedisce di eseguire un test IP Flow Verify completo perché non esiste una NIC associata a una macchina in esecuzione da utilizzare come endpoint reale. Tuttavia, il conflitto tra le regole NSG può essere individuato analizzandone priorità, direzione, sorgente, destinazione, protocollo e porta. In particolare, la regola Deny-Web-Postgres con priorità 250 viene valutata prima della Allow-Web-Postgres con priorità 300 e quindi prevale sul traffico TCP verso la porta 5432.

6. La regola "Deny-Web-Postgres-Auto" è stata eliminata. Verifica:
Priority    Name                Access    Source         Port
----------  ------------------  --------  -------------  ------
300         Allow-Web-Postgres  Allow     10.50.10.0/24  5432

7. 
# InvalidAddressPrefix
- Livello: configurazione rete / indirizzamento
- Controllo: verificare CIDR e prefissi IP di VNet, subnet, NSG o route
- Correzione minima: correggere il prefisso IP non valido.

# SecurityRuleConflict
- Livello: NSG / sicurezza
- Controllo: verificare le regole NSG, soprattutto priorità, direzione, sorgente, destinazione, porta e protocollo
- Correzione minima: modificare o eliminare la regola in conflitto.

# Un nome DNS non viene risolto 
- Livello: DNS / risoluzione dei nomi
- Controllo: verificare il DNS configurato, il server DNS e i record
- Correzione minima: correggere il record DNS o la configurazione del DNS.

# La porta risulta filtrata da un NSG 
- Livello: NSG / connettività
- Controllo: verificare le regole NSG effettive e la priorità della prima regola corrispondente 
- Correzione minima: modificare o rimuovere la regola Deny che blocca il traffico.