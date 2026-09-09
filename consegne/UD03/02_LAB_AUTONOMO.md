1. Principal, ruolo e scope
Principal: il gruppo grp-cea-readers-<suffisso>.
Ruolo: Reader.
Scope: Resource Group LAB_RG.
Motivazione: Reader è sufficiente perché il team deve consultare le risorse senza modificarle.
Non userei Contributor perché consente di creare, modificare ed eliminare risorse.
Non userei Owner perché, oltre ai privilegi di gestione delle risorse, permette di gestire anche le assegnazioni RBAC.
La scelta segue il principio del minimo privilegio.

Role     PrincipalType    Scope
-------  ---------------  --------------------------------
Owner    User             /subscriptions/<SUBSCRIPTION_ID>
Questa assegnazione è ereditata, perché lo scope è la subscription.
2. 
Role    PrincipalType    Scope
------  ---------------  ---------------------------------------------------
Owner   User             <SUBSCRIPTION_ID>
root@DESKTOP-LPG6CNL:~/workspace/azure-devops-lab# az role assignment list \
  --scope "$RG_SCOPE" \
  --include-inherited \
  --output table
Principal                                                     Role    Scope
------------------------------------------------------------  ------  ---------------------------------------------------
 Owner   <SUBSCRIPTION_ID>

3. Diretta vs ereditata e Reader temporaneo
-Owner sull'utente → ereditata, perché assegnata alla subscription.
-Reader al gruppo grp-cea-readers-<suffisso> sul LAB_RG → diretta, se l'assegnazione è stata effettuata direttamente sul Resource Group.
-L'assegnazione Reader non riduce né sostituisce un ruolo più ampio già posseduto dall'utente.
-Se un utente possiede Owner sulla subscription, aggiungergli Reader sul Resource Group non gli fa perdere Owner.
-Per questo motivo è importante controllare tutte le assegnazioni applicabili, comprese quelle ereditate.

4. Budget

Amount    Category    TimeGrain
--------  ----------  ---------
20.0      Cost        Monthly

Quindi puoi scrivere:

Importo: 20.0
Categoria: Cost
Periodicità: Monthly
È stato configurato un budget mensile di 20.
Il budget serve al monitoraggio e agli avvisi, ma non garantisce automaticamente che la spesa non superi tale cifra.

5. Lock
Nome             Livello
---------------  ------------
lock-cea-delete  CanNotDelete

eliminazione → bloccata;
lettura → consentita.

6. Risolvere errori
A: 
rimedio: az login;
B: 
rimedio: usare un principal con permessi RBAC adeguati;
C: 
rimedio: rimuovere il lock solo se autorizzati e se è necessario

7. cleanup
- Eliminare l'eventuale role assignment temporanea Reader
- Eliminare l'eventuale gruppo temporaneo creato per il laboratorio
- Rimuovere il lock temporaneo, se previsto dal laboratorio
- Eliminare il Resource Group del laboratorio
-  Verificare che il Resource Group non esista più