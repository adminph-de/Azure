# Azure Simple VM for Operations POC (SANDBOX)
This example is based on the requitements for internel FLSmidth POC to deploy VMs in a simple way.

## Deploying Samples

You can deploy these samples directly through the Azure Portal or by using the scripts supplied in the root of the repo.
To deploy a sample using the Azure Portal, click the **Deploy to Azure** button found in the README.md of each sample.

To deploy the sample via the command line (using [Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure/overview) or the [Azure CLI 1.0](https://docs.microsoft.com/en-us/azure/cli-install-nodejs)) you can use the scripts below.

Simply execute the script and pass in the folder name of the sample you want to deploy.  

For example:

### PowerShell
```PowerShell
.\001-FLS_SimpleVM_1.0-deploy.ps1 \
 -ResourceGroupLocation 'westeurope' \
 -SubscriptionId '[yourSubscriptioniD]' \
 -resourceGroupName '[yourResourceGroup]' \
 -deploymentName '[yourDeploymentName]'
```