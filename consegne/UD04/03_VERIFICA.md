# Parte A
1. A
2. B
3. B
4. B
5. B
6. C
7. B
8. A

#Parte B

9. Distingui ridondanza e backup.

La ridondanza mantiene più copie dei dati per aumentare disponibilità e resilienza, ad esempio in zone o regioni diverse. Il backup permette invece di recuperare i dati da uno stato precedente dopo cancellazioni o modifiche accidentali. La ridondanza non sostituisce il backup perché una modifica o cancellazione può essere replicata.

10. Distingui management plane e data plane con un comando per ciascuno.

Il management plane riguarda la gestione della risorsa Azure, ad esempio creare o configurare uno Storage Account. Esempio:
az storage account show --name "$LAB_STORAGE" --resource-group "$LAB_RG"

Il data plane riguarda invece i dati contenuti nello Storage Account, ad esempio caricare o leggere un Blob:
az storage blob list --account-name "$LAB_STORAGE" --container-name "$LAB_CONTAINER" --auth-mode login

11. Elenca quattro proprietà di una SAS a minimo privilegio.

Permessi minimi necessari.
Scope limitato alla risorsa necessaria.
Durata breve.
Utilizzo tramite HTTPS.

12. Spiega perché Archive non è appropriato per dati da recuperare immediatamente.

Archive è pensato per dati consultati molto raramente ed è un tier offline. Per accedere ai dati è necessario effettuare la reidratazione, che richiede tempo e può comportare costi di recupero. Per dati che devono essere disponibili immediatamente è quindi più appropriato un tier online come Hot, Cool o Cold, in base al caso d'uso.

13. Perché non bisogna salvare account key o SAS nel repository?

Perché sono credenziali che possono permettere l'accesso ai dati. Se vengono pubblicate in un repository, possono essere utilizzate da persone non autorizzate. Devono quindi essere protette e, in caso di esposizione, revocate o ruotate.

# Parte C

14. Individua almeno tre problemi.

- Contributor sullo Storage Account non garantisce automaticamente l'accesso ai dati Blob tramite Microsoft Entra ID.
- Non utilizzare --auth-mode login può portare all'utilizzo di credenziali alternative, come account key.
- Condividere una account key espone un segreto con privilegi elevati.
- Una SAS con permessi completi viola il principio del minimo privilegio.
- Una SAS senza una scadenza breve aumenta il rischio in caso di esposizione.

15. Proponi autorizzazione e scope più appropriati.

Userei Microsoft Entra ID con Azure RBAC del data plane, assegnando il ruolo minimo necessario e allo scope più ristretto possibile. Per esempio, Storage Blob Data Reader sul singolo container o, se necessario, sullo Storage Account. Per un'applicazione che deve anche modificare i Blob si valuterebbe Storage Blob Data Contributor.

Per un accesso temporaneo e limitato a un singolo documento, userei invece una SAS con soli permessi necessari e durata breve.

16. Indica come verificheresti accesso e cleanup senza pubblicare segreti.

Verificherei l'accesso usando --auth-mode login oppure una SAS mantenuta soltanto in una variabile temporanea, senza stamparne né salvarne il valore. Controllerei la presenza e le proprietà del Blob con az storage blob show o az storage blob list.

Per il cleanup eliminerei le risorse temporanee, i Blob e i container creati durante il laboratorio e rimuoverei eventuali assegnazioni o credenziali temporanee. Infine verificherei che non siano rimaste risorse. Token SAS, account key e URL firmati non devono essere inseriti nel repository.