# Verifica — Identità, accessi, governance e costi

## Parte A 

1. B

2. D

3. C

4. B

5. B

6. C

7. B

8. B

## Parte B 

9. Assegnare ruoli a un gruppo è spesso preferibile perché semplifica la gestione dei permessi: si assegna il ruolo una volta al gruppo e si gestiscono successivamente i membri senza creare numerose assegnazioni individuali.

10. Un ruolo Microsoft Entra gestisce principalmente identità e funzionalità della directory. Ad esempio, un ruolo amministrativo può consentire di creare utenti. Un ruolo Azure RBAC gestisce l'accesso alle risorse Azure. Ad esempio, `Reader` permette di leggere un resource group senza modificarlo.

11. L'accesso effettivo comprende sia `Reader` sia `Contributor`, ma prevale il permesso più ampio applicabile. In questo caso l'utente può modificare le risorse perché `Contributor` è ereditato dalla sottoscrizione. L'assegnazione `Reader` sul resource group non riduce i privilegi già posseduti tramite lo scope superiore.

12. Per diagnosticare `AuthorizationFailed`:

13. verificare l'autenticazione con `az account show`;

14. verificare la sottoscrizione e il contesto corrente;

15. controllare le role assignment del principal;

16. verificare lo scope dell'operazione e i ruoli ereditati;

17. controllare eventuali lock o policy applicabili.

18. `deleteAfter` è un tag informativo e da solo non elimina le risorse. `CanNotDelete` è un lock che impedisce l'eliminazione dello scope protetto. Un budget monitora la spesa e può generare notifiche al raggiungimento delle soglie, ma non costituisce automaticamente un limite rigido alla spesa.

## Parte C 

14. Due interpretazioni errate sono:

* assegnare `Contributor` all'intera sottoscrizione quando serve soltanto consultare una VNet in un singolo resource group;
* ritenere che `Contributor` permetta automaticamente di assegnare ruoli RBAC ad altri utenti;
* interpretare `ScopeLocked` come un problema di autorizzazione anziché come effetto di un resource lock.

15. La scelta iniziale più appropriata è assegnare il ruolo Reader allo scope `rg-network-prod`, perché il tecnico deve soltanto consultare la VNet e non deve modificare le risorse.

16. Il tecnico non riesce ad assegnare `Reader` al collega perché `Contributor` normalmente permette di gestire le risorse, ma non di creare o modificare role assignment. Per questa operazione serve un ruolo che includa `Microsoft.Authorization/roleAssignments/write`, ad esempio `Owner` o un ruolo RBAC specifico per la gestione degli accessi.

Non riesce invece a eliminare lo scope perché è presente un resource lock `CanNotDelete` applicabile al resource group. Il lock impedisce l'eliminazione finché rimane attivo, indipendentemente dal fatto che il tecnico abbia privilegi sufficienti per gestire le risorse.
