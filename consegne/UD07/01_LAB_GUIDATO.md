1. Ho controllato login e account 

2. Preparo le varibili

3. Creo il resource group. Il risultato di ProvisioningState è Succeeded

4. Leggo lo script e lo eseguo. Inixialmente è comparso "Il Resource Group non esiste: lo creo."; rieseguendolo, dopo la creazione, è comparso "Il Resource Group esiste già: lo riutilizzo."

Lo script è più sicuro perché prima di creare il Resource Group verifica se esiste già. Se non esiste lo crea, mentre se esiste lo riutilizza. In questo modo evita di tentare inutilmente una nuova creazione della stessa risorsa e rende lo script riutilizzabile anche dopo una seconda esecuzione.

5. In questo punto abbiamo messo a confronto tre output relativi al resource group.
Con --query selezioniamo solo le proprietà più utili; con  tsv e json un unico valore;
Table lo preferiamo quando abbiamo bisogno di vedere tutte le caratteristiche più importanti del RG, mentre tsv quando ci serve solo un'informazione.

6. Adesso utilizzando la powershell del portale azure, abbiamo creato un resource group nuovo, utilizzando lo stesso principio di prima.
ResourceGroupName Location   ProvisioningState Tags
----------------- --------   ----------------- ----
rg-ud07-ps-test   westeurope Succeeded        

