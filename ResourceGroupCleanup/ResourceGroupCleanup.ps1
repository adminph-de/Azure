#Removes all objectes in a Resource Group
New-AzureRmResourceGroupDeployment -ResourceGroupName MyResourceGroup -Mode Complete -TemplateFile .\ResourceGroupCleanup.template.json -Force -Verbose
