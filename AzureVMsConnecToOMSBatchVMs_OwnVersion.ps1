# Author - Ravi Yadav, MVP
# October 16, 2017
# This script will connect all of your VMs within a given Resource Group to your OMS/Log Analytics workspace
# Lines 6,7,8,9 need to be updated with respect to your environment

Login-AzureRMAccount

$workspaceSubscriptionName = "GBS OMS"
$workspaceSubscriptionID = "3cd22767-fac5-4cc6-993a-32655d34eeb8" 
$workspaceName = "fls-oms"
$workspaceResourcegroup = "ams-oms"

$SubscriptionName = "FLS GBS Azure Subscription"
$SubscriptionID = "67d97890-89f4-4294-9de2-81f74a631242"
$vmresourcegroup = "ams-infra-server"

Select-AzureRmSubscription $workspaceSubscriptionName

$workspace = Get-AzureRmOperationalInsightsWorkspace -Name $workspaceName -ResourceGroupName $WorkspaceResourcegroup

if ($workspace.Name -ne $workspaceName)
{
    Write-Error "Unable to find OMS Workspace $workspaceName."
}

$workspaceId = $workspace.CustomerId
$workspaceKey = (Get-AzureRmOperationalInsightsWorkspaceSharedKeys -ResourceGroupName $workspace.ResourceGroupName -Name $workspace.Name).PrimarySharedKey
#get all vms within the resource group

Select-AzureRmSubscription $SubscriptionName
$vms = Get-AzureRmVM -ResourceGroupName $vmresourcegroup 

foreach ($vm in $vms)
{
    $location = $vm.Location
    $vm = $vm.Name  
    # For Windows VM uncomment the following line
    Set-AzureRmVMExtension -ResourceGroupName $vmresourcegroup -VMName $vm -Name 'MicrosoftMonitoringAgent' -Publisher 'Microsoft.EnterpriseCloud.Monitoring' -ExtensionType 'MicrosoftMonitoringAgent' -TypeHandlerVersion '1.0' -Location $location -SettingString "{'workspaceId': '$workspaceId'}" -ProtectedSettingString "{'workspaceKey': '$workspaceKey'}"
}