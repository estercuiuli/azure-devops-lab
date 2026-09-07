````markdown
# Nota operativa — UD01

La cartella di lavoro si trova nel filesystem Linux di WSL 2 ed è stata aperta con Visual Studio Code tramite l'estensione WSL.

Il controllo che ha dimostrato il corretto contesto di esecuzione è:

```bash
pwd
```

L'output indicava un percorso interno alla home Linux e non un percorso `/mnt/c`.
````

# Prova pratica
1. Il comando git status è particolarmente utile perché permette di verificare lo stato del working tree e della staging area prima di creare un commit.
2. Procedimento:
-Con git diff si controlla che la nuova frase evidenzi la modifica del file.
-Con git add si prepara il file per il commit, inserendolo nella staging area.
-Con git status si controlla lo stato del file e si verifica che sia pronto per il commit.
-Con git commit si salva la modifica nella cronologia locale.
-Infine, con git push si invia il commit al repository remoto.