# Create a simple VM
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fadminph-de%2FAzure%2Fmaster%2Farm-templates%2F101-simple-vm-deployment%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>
<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2Fadminph-de%2FAzure%2Fmaster%2Farm-templates%2F101-simple-vm-deployment%2Fazuredeploy.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

This template allows the Operation Team to create a simple VM including attaching the VM to a Backup Scheduler, Log Diagnostic Storage Account, BGInfo and Antimalware extentions.

<u><b>Notes:</u></b>
The templated expectes a backup vault: "ams-server-backup-1" in the resource group: "ams-backup" and a storage account to store the diagnostic logs: "amsserverdiag1" in the resource group: "ams-server". Check the variables to change the name or the resource group before you start the deployment process in Azure.