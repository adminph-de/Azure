 <#
 .SYNOPSIS
    Easy way to remove all VMs of a Resource Group incl. related objects.

 .DESCRIPTION
    Executable on PowerShell Command Line. 
    Prerequtements: Azure PowerShell modules

 .PARAMETER SubscriptionId
    Azure Subsription ID where the VMs (objectes) are related to.

 .PARAMETER ResourceGroupName
    Azure Resource Group where the VMs (objects) are located.

#>
param(
  [Parameter(Position = 0, Mandatory = $true)]
  [string]
  $SubscriptionId,

  [Parameter(Position = 1, Mandatory = $true)]
  [string]
  $ResourceGroupName
)
$ErrorAction = 'Stop'

$null = Set-AzureRmContext -SubscriptionId $SubscriptionId

@(
  'Microsoft.Compute/virtualMachines'
  'Microsoft.Compute/disks'
  'Microsoft.Network/networkInterfaces'
  'Microsoft.Network/publicIPAddresses'
  'Microsoft.Compute/restorePointCollections'

  #'*' # this will remove everything else in the resource group regarding of resource type
) | % {
  $params = @{
    'ResourceGroupNameContains' = $ResourceGroupName
  }

  if ($_ -ne '*') {
    $params.Add('ResourceType', $_)
  }

  $resources = Find-AzureRmResource @params
  $resources | Where-Object { $_.ResourceGroupName -eq $ResourceGroupName } | % { 
   Write-Host ('Processing {0}/{1}' -f $_.ResourceType, $_.ResourceName)
   $_ | Remove-AzureRmResource -Verbose -Force
  }
}