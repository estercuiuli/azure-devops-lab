# PARTE A
1. B
2. B
3. B
4. A
5. A
6. A
7. B
8. B

# PARTE B
9. 
Perché gli indirizzi IP disponibili in una subnet sono limitati. Lasciare spazio permette di aggiungere in futuro nuove VM, NIC e servizi senza dover modificare la struttura della rete o ricreare le subnet.

10. 
NSG: controlla se il traffico di rete è consentito o negato in base a regole come IP, porta e protocollo.
Route: determina dove viene indirizzato il traffico.
DNS: traduce i nomi in indirizzi IP.

11. 
Un NSG è stateful: se una connessione viene consentita in una direzione, il traffico di risposta associato a quella connessione viene automaticamente consentito, senza dover creare una regola esplicita per il traffico di ritorno.

12. 
Perché applicando l'NSG alla subnet, le regole di sicurezza comuni vengono applicate automaticamente alle risorse presenti nella subnet. Questo riduce la necessità di configurare e mantenere separatamente ogni NIC.

13. 
Si possono verificare la configurazione della NIC, la subnet di appartenenza e le associazioni configurate. Si può inoltre analizzare la configurazione dell'NSG associato alla subnet.
Manca però una prova di connettività reale: senza una VM in esecuzione non è possibile effettuare un test completo con IP Flow Verify né verificare una connessione applicativa reale.

# PARTE C

14. Perché il cambio di nome non modifica l'esito?
Perché il nome della regola è solo un identificativo. Non determina il comportamento della regola.
La regola Deny-Web con priorità 150 viene valutata prima della Allow-Web con priorità 400 e quindi il traffico viene negato.

Per esempio, cambiare:
Allow-Web
in:
AAA-Allow-Web
non modifica né la priorità né l'azione della regola.

15. La correzione minima è rimuovere o modificare la regola Deny-Web con priorità 150, mantenendo la regola Allow limitata alla sorgente:
10.60.10.0/24
e alla porta:
TCP 443
In questo modo si consente solo il traffico previsto, senza permettere l'accesso da Internet.

16. 
Controllerei, in ordine:
- NSG: verificare le regole effettive e che non ci siano altri Deny.
- Route: verificare che esista un percorso corretto verso la destinazione.
- DNS: verificare che il nome risolva correttamente nell'indirizzo IP previsto.
- IP e subnet: verificare indirizzi e prefissi.
- Porta 443:  verificare che il servizio sia effettivamente in ascolto.
- VM/NIC: verificare che la VM sia accesa e che la NIC sia configurata correttamente.
- Applicazione: solo dopo aver escluso i problemi di rete, verificare che l'applicazione funzioni correttamente.