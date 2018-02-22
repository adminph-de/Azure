# -------------------------------------------------------------------------------- #
       #  Provide the value for the following parameters before executing the script
$subscriptionId = '92456d20-c3a9-4ccf-b217-4779f359517a'    
$keyvaultName = 'ams-test-keyvault-1'
       $secretName = 'CRM8DataExportSecret'
       $resourceGroupName = 'ams-test-core-network'
       $location = 'West Europe'
       $connectionString = 'Server=tcp:fls-test-1.database.windows.net,1433;Initial Catalog=ams-test-crm;Persist Security Info=False;User ID={your_username};Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
            
$organizationIdList = 'e7ec8b7d-b58b-46cb-8a3b-e584995a6698'
$tenantId = '5a783410-682d-4564-b908-bb78d5afb2fe '
       # -------------------------------------------------------------------------------- #

# Login to Azure account, select subscription and tenant Id
Login-AzureRmAccount
Set-AzureRmContext -TenantId $tenantId -SubscriptionId $subscriptionId

# Create new resource group if not exists.
$rgAvail = Get-AzureRmResourceGroup -Name $resourceGroupName -Location $location -ErrorAction SilentlyContinue
if(!$rgAvail){
    New-AzureRmResourceGroup -Name $resourceGroupName -Location $location
}

# Create new key vault if not exists.
$kvAvail = Get-AzureRmKeyVault -VaultName $keyvaultName -ResourceGroupName $resourceGroupName -ErrorAction SilentlyContinue
if(!$kvAvail){
    New-AzureRmKeyVault -VaultName $keyvaultName -ResourceGroupName $resourceGroupName -Location $location
    # Wait few seconds for DNS entry to propagate
    Start-Sleep -Seconds 15
}

# Create tags to store allowed set of Organizations.
$secretTags = @{}
foreach ($orgId in $organizationIdList.Split(',')) {
    $secretTags.Add($orgId.Trim(), $tenantId)
}

# Add or update a secret to key vault.
$secretVaule = ConvertTo-SecureString $connectionString -AsPlainText -Force
$secret = Set-AzureKeyVaultSecret -VaultName $keyvaultName -Name $secretName -SecretValue $secretVaule -Tags $secretTags

# Authorize application to access key vault.
$servicePrincipal = 'b861dbcc-a7ef-4219-a005-0e4de4ea7dcf'
Set-AzureRmKeyVaultAccessPolicy -VaultName $keyvaultName -ServicePrincipalName $servicePrincipal -PermissionsToSecrets get

# Display secret url.
Write-Host "Connection key vault URL is "$secret.id.TrimEnd($secret.Version)"" 
