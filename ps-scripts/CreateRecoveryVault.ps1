Login-AzureRmAccount -Subscription "FLS GBS Azure Subscription"

$VaultList = Get-AzureRmRecoveryServicesVault
foreach ($Vault in $VaultList)
 {
    $Vault.Name
 }

$ResourceGroupName = "ams-server"
$RecoveryServicesVaultName = "amsserverbackupvault1"
Get-AzureRmRecoveryServicesVault -ResourceGroupName $ResourceGroupName -Name $RecoveryServicesVaultName

$GetVault = Get-AzureRmRecoveryServicesVault -ResourceGroupName $ResourceGroupName
if(!$GetVault){
    New-AzureRmRecoveryServicesVault -Name $RecoveryServicesVaultName -ResourceGroupName $ResourceGroupName
}

$VaultName = $RecoveryServicesVaultName -replace("[0-9]", "")
$VaultCount = (($RecoveryServicesVaultName -replace("[a-zA-Z]", "")) -as [int]) + 1
write-host $VaultName$VaultCount


