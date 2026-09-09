1. Perché autenticazione riuscita e autorizzazione sufficiente non sono equivalenti?
L’autenticazione verifica chi sei, mentre l’autorizzazione stabilisce cosa puoi fare. Essere autenticati non significa avere i permessi necessari per una determinata operazione.
2. 
Quale differenza operativa esiste tra ruolo Microsoft Entra e ruolo Azure?
Un ruolo Microsoft Entra gestisce principalmente identità e accesso alla directory, mentre un ruolo Azure RBAC controlla le operazioni sulle risorse Azure, come creare, modificare o leggere una VM.
3. 
Quali tre elementi formano una role assignment?
Principal + Role + Scope:
-chi riceve il permesso;
-quale ruolo riceve;
-su quale ambito si applica.
4. 
Perché Reader su un resource group è preferibile a Contributor sulla sottoscrizione quando serve soltanto consultare quel progetto?
Perché applica il principio del minimo privilegio: Reader permette di consultare le risorse senza modificarle e il resource group limita il permesso al solo progetto necessario.
5. 
Perché un ruolo ereditato non si rimuove dalla risorsa figlia?
Perché il ruolo è assegnato a un ambito superiore e viene ereditato dalle risorse sottostanti. Per eliminarlo dalla figlia bisogna rimuovere o modificare l’assegnazione nello scope in cui è stata effettivamente creata.
6. 
Un tag deleteAfter impedisce l’eliminazione? Motiva.
No. Un tag è solo un'informazione/metadato. L’eliminazione avviene solo se esiste un processo, una policy o un’automazione che interpreta quel tag.
7. 
Che cosa cambia tra lock CanNotDelete e ruolo Reader?
Reader controlla i permessi dell'utente: permette di leggere ma non modificare.
CanNotDelete è un blocco sulla risorsa: impedisce l’eliminazione anche a utenti che normalmente avrebbero il permesso di cancellarla.
8. 
Perché un budget non è sufficiente a garantire che la spesa non superi una cifra?
Perché un budget serve principalmente a monitorare la spesa e generare alert. Non costituisce automaticamente un limite di spesa né spegne le risorse quando viene raggiunta la soglia.