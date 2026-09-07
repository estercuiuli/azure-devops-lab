# VERIFICA
1. B
2. C
3. C
4. C
5. A
6. A
7. C
8. B
9. C

10. Differenza fra Git e GitHub

Git è un sistema di controllo versione che permette di tracciare le modifiche e creare commit localmente.
GitHub è una piattaforma online che ospita repository Git remoti e permette di collaborare e condividere il codice.

11. 
Prendiamo ad esempio il file "nota-operativa.md":

git status: controllo lo stato delle modifiche.

git add laboratori/UD01/nota-operativa.md:  preparo il file per il commit, inserendolo nella staging area.

git commit -m "Aggiorna nota operativa": creo il commit locale.

git push: invio il commit al repository remoto.

12. 
Prima di wsl --update controllerei:

La versione e lo stato attuale di WSL, per capire se l'aggiornamento è realmente necessario.
La compatibilità dell'ambiente con il workflow del corso, verificando che l'aggiornamento non introduca problemi con Ubuntu, VS Code o altri strumenti già configurati.

13. 
Sospetto che VS Code sia aperto in modalità Windows e non collegato a WSL, anche se il progetto è stato aperto con code .
Verificherei l'indicatore nell'angolo in basso a sinistra di VS Code, che dovrebbe mostrare:
WSL: Ubuntu e controllerei il terminale con
pwd. Mi aspetto un percorso Linux come:
/root/workspace/azure-devops-lab
e non un percorso C:\Users\...

14. 
Il problema non è risolto perché il token rimane nella cronologia Git, anche se la riga viene eliminata con un secondo commit.
Bisogna considerare il token compromesso, revocarlo/rigenerarlo e, se necessario, rimuoverlo anche dalla cronologia del repository.