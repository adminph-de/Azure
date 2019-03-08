function Mount-StorageAccountShare {

param(
 [Parameter(Mandatory=$True)]
 [string]$File
)

    $JSON = Get-Content $File | Out-String | ConvertFrom-Json

    $AcctKey = ConvertTo-SecureString -String $JSON.parameters.StorageAccountKey.value -AsPlainText -Force
    $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $JSON.parameters.StorageAccountUser.value, $acctKey
    if ((Test-Path -Path ($JSON.parameters.StorageAccountShareDirve.value + ":\") )) {
          Remove-PSDrive -Name $JSON.parameters.StorageAccountShareDirve.value
    }
    else {
       Write-Host
       Write-Host "Mounting in progress....." -ForegroundColor Red
       Write-Host 
       New-PSDrive `
        -Name $JSON.parameters.StorageAccountShareDirve.value `
        -PSProvider FileSystem -Root ("\\" + $JSON.parameters.StorageAccountName.value + ".file.core.windows.net\" + $JSON.parameters.StorageAccountShare.value) `
        -Credential $credential -Persist   
    }

}