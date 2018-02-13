# Create a simple VM
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fadminph-de%2FAzure%2Fmaster%2Farm-templates%2F101-simple-vm-deployment%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fadminph-de%2FAzure%2Fmaster%2Farm-templates%2F101-simple-vm-deployment%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows the Operation Team to create a simple VM in the "GBS Azure Subscription".
<p>
<u>Deployment includes:</u><br>
Adding to Backup<br>
Log Diagnostic<br>
Extentions: BGInfo and Antimalware
</p>

<u><b>Notes:</u></b>
The template expectes a backup vault: "ams-server-backup-1" in the resource group: "ams-backup" and a storage account to store the diagnostic logs: "amsserverdiag1" in the resource group: "ams-server". Check the variables to change the name or the resource group before you start the deployment process in Azure.