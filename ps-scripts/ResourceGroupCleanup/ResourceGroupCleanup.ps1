#Removes all objectes in a Resource Group
New-AzureRmResourceGroupDeployment -ResourceGroupName ams-server -Mode Complete -TemplateFile .\ResourceGroupCleanup.template.json -Force -Verbose
