### Descrizione delle attività svolte

È stato creato un Azure Storage Account configurato con StorageV2, ridondanza Standard_LRS, accesso HTTPS obbligatorio, TLS 1.2 e accesso pubblico ai Blob disabilitato.

All'interno del container `documents` è stato caricato il file `01_DOCUMENTO_LAB.txt`, verificandone il tipo `BlockBlob`, il tier `Hot`, la dimensione di 49 byte e il `Content-Type` `text/plain`.

Successivamente è stato creato e caricato il Blob `temporary/temporaneo.txt`, utilizzato per verificare le operazioni da Azure CLI tramite autenticazione Microsoft Entra ID con `--auth-mode login`.

È stata inoltre verificata l'operazione di download del Blob `documento-lab.txt` e confrontato il file scaricato con l'originale tramite `cmp`, verificandone la corrispondenza.

Per comprendere la differenza tra autenticazione tramite identità e Shared Key, è stata effettuata anche una lettura utilizzando temporaneamente la chiave dello Storage Account, mantenendola esclusivamente in una variabile di ambiente e rimuovendola al termine dell'operazione.

È stata quindi generata una User Delegation SAS con permesso di sola lettura (`r`) limitata al singolo Blob `documento-lab.txt`, con durata di 30 minuti. L'accesso tramite SAS è stato verificato con successo e le variabili contenenti il token sono state rimosse al termine della verifica.

Infine è stata configurata dal portale la regola di Lifecycle Management `delete-temporary`, abilitata per i Blob con prefisso `documents/temporary/`, con eliminazione prevista dopo un giorno dall'ultima modifica. La configurazione è stata verificata tramite Azure CLI.

Name                  Blob Type    Blob Tier    Length    Content Type    Last Modified              Snapshot
--------------------  -----------  -----------  --------  --------------  -------------------------  ----------
01_DOCUMENTO_LAB.txt  BlockBlob                 49        text/plain    

Name                      Blob Type    Blob Tier    Length    Content Type    Last Modified              Snapshot
------------------------  -----------  -----------  --------  --------------  -------------------------  ----------
01_DOCUMENTO_LAB.txt      BlockBlob    Hot          49        text/plain      2026-09-10T09:39:00+00:00
temporary/temporaneo.txt  BlockBlob    Hot          30        text/plain 

Name               Blob Type    Blob Tier    Length    Content Type    Last Modified              Snapshot
-----------------  -----------  -----------  --------  --------------  -------------------------  ----------
documento-lab.txt  BlockBlob                 49        text/plain      202


