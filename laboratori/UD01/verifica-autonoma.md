  NAME            STATE           VERSION
* Ubuntu          Running         2
  Ubuntu-24.04    Stopped         2

- il percorso Linux del repository: /root/workspace/azure-devops-lab

- l'URL del remote: origin  https://github.com/estercuiuli/azure-devops-lab.git (fetch)
origin  https://github.com/estercuiuli/azure-devops-lab.git (push)

- Differenza tra le 4 aree Git

Working tree: i file presenti nella cartella di lavoro, comprese le modifiche non ancora preparate.
Staging area: contiene le modifiche selezionate con git add, pronte per il commit.
Commit locale: una versione salvata nella cronologia Git locale tramite git commit.
Repository remoto: la copia del repository su GitHub, aggiornata ad esempio con git push.

- il controllo usato per verificare Azure CLI: az version
Per il login :
az login
az account show

- lo stato verificato dell'invito al docente: l'invito è stato accettato dal docente

- un possibile errore di contesto e il comando che permette di riconoscerlo:
un possibile errore di contesto consiste nell'eseguire comandi Git al di fuori del repository, situazione riconoscibile con git status.