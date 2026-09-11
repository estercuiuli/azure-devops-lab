1. Uno switch collega dispositivi all'interno della stessa rete e inoltra i frame usando principalmente gli indirizzi MAC.
Un router collega reti diverse e inoltra i pacchetti usando gli indirizzi IP e le tabelle di routing.
2. Il MAC address identifica l'interfaccia di rete a livello data link (Layer 2).
L'IP address identifica logicamente un dispositivo/interfaccia all'interno di una rete a livello network (Layer 3) e permette il routing.
3. È una notazione CIDR e indica che i primi 24 bit dell'indirizzo IPv4 identificano la rete, rappresenta una rete di 256 indirizzi complessivi.
4. È l'indirizzo del dispositivo/router a cui un host invia il traffico destinato a reti diverse dalla propria. 
5. DHCP (Dynamic Host Configuration Protocol) assegna automaticamente ai dispositivi i parametri necessari per comunicare in rete.
Può fornire:
-indirizzo IP
-subnet mask/prefix
-default gateway
-server DNS
6. DNS (Domain Name System) traduce i nomi in indirizzi IP. DNS non autorizza il traffico e non determina se una connessione può effettivamente essere stabilita.
7. TCP è orientato alla connessione e garantisce una trasmissione affidabile. È usato, ad esempio, da HTTP/HTTPS.
Offre:
controllo degli errori
ritrasmissione dei dati persi
ordinamento dei pacchetti
controllo del flusso
UDP è connectionless e non garantisce consegna, ordine o ritrasmissione. È generalmente più semplice e con meno overhead.
Viene utilizzato, ad esempio, in DNS e applicazioni real-time.
8. Una porta è un numero utilizzato dal sistema operativo per identificare un particolare servizio/processo all'interno di un host.
Gli indirizzi identificano dove andare, mentre la porta quale servizio.
9. Una route indica al sistema come raggiungere una determinata rete o destinazione.
10. Un firewall controlla il traffico di rete e decide se permetterlo o bloccarlo in base a determinate regole.
11. Una VLAN (Virtual LAN) permette di suddividere logicamente una rete locale fisica in più reti separate.
12. VLAN è una tecnologia di rete locale, tipicamente associata a infrastruttura fisica e switching Layer 2.
VNet è una rete virtuale di Azure, cioè uno spazio di rete definito logicamente nel cloud, con:
-subnet
-indirizzi IP
-routing
-NSG
-peering
-altri servizi di rete
13. NAT (Network Address Translation) modifica gli indirizzi IP, tipicamente permettendo a dispositivi con IP privati di comunicare verso reti esterne utilizzando un indirizzo pubblico.
14. Una DMZ (Demilitarized Zone) è una zona di rete separata nella quale vengono collocati servizi che devono essere raggiungibili da reti meno fidate, come Internet.
L'obiettivo è isolamento e riduzione del rischio: se un server esposto viene compromesso, non dovrebbe avere automaticamente accesso libero alla rete interna.
15. Una VPN (Virtual Private Network) crea una connessione privata, generalmente tramite un tunnel cifrato, attraverso una rete non fidata come Internet. Permette quindi di collegare in modo sicuro utenti o reti distanti.
16. Su Windows mostra informazioni dettagliate sulla configurazione delle interfacce di rete.
Tra le informazioni più importanti:
indirizzo IPv4
indirizzo IPv6
subnet mask/prefix
default gateway
server DNS
indirizzo MAC/Physical Address
informazioni DHCP
stato delle schede di rete
17. nslookup serve principalmente a verificare la risoluzione DNS, cioè permette di vedere quale indirizzo IP viene restituito dal DNS.
18. Perché il DNS risolve solamente il nome in un indirizzo IP.
Se, ad esempio, la porta 443 è bloccata da un NSG, il DNS continuerà a funzionare ma l'applicazione non sarà raggiungibile.