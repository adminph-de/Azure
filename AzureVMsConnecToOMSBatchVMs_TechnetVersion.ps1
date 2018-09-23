# Author - Ravi Yadav, MVP
# October 16, 2017
# This script will connect all of your VMs within a given Resource Group to your OMS/Log Analytics workspace
# Lines 6,7,8,9 need to be updated with respect to your environment

Login-AzureRMAccount -SubscriptionName "FLS GBS Azure Subscription"
Select-AzureRMSubscription -SubscriptionId "67d97890-89f4-4294-9de2-81f74a631242" 
$workspaceName = "fls-core"
$resourcegroup = "ams-core-oms"
$vmresourcegroup = "ams-infra-server"
$workspace = Get-AzureRmOperationalInsightsWorkspace -Name $workspaceName -ResourceGroupName $resourcegroup

if ($workspace.Name -ne $workspaceName)
{
    Write-Error "Unable to find OMS Workspace $workspaceName."
}

$workspaceId = $workspace.CustomerId
$workspaceKey = (Get-AzureRmOperationalInsightsWorkspaceSharedKeys -ResourceGroupName $workspace.ResourceGroupName -Name $workspace.Name).PrimarySharedKey
#get all vms within the resource group
$vms = Get-AzureRmVM -ResourceGroupName $vmresourcegroup 

foreach ($vm in $vms)
{
    $location = $vm.Location
    $vm = $vm.Name  
    # For Windows VM uncomment the following line
    Set-AzureRmVMExtension -ResourceGroupName $vmresourcegroup -VMName $vm -Name 'MicrosoftMonitoringAgent' -Publisher 'Microsoft.EnterpriseCloud.Monitoring' -ExtensionType 'MicrosoftMonitoringAgent' -TypeHandlerVersion '1.0' -Location $location -SettingString "{'workspaceId': '$workspaceId'}" -ProtectedSettingString "{'workspaceKey': '$workspaceKey'}"
}