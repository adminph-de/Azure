function Mount-StorageAccountShare {

param(
 [Parameter(Mandatory=$True)]
 [string]$File
)

    $JSON = Get-Content $File | Out-String | ConvertFrom-Json

    $AcctKey = ConvertTo-SecureString -String $JSON.parameters.StorageAccountKey.value -AsPlainText -Force
    $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $JSON.parameters.StorageAccountUser.value, $acctKey

    #if ((Test-Path -Path ($JSON.parameters.StorageAccountShareDirve.value + ":\") )) {
    #      Remove-PSDrive -Name $JSON.parameters.StorageAccountShareDirve.value
    #      Write-Host
    #      Write-Host "Drive Letter in uses.... Removeing...." -ForegroundColor Red
    #      Write-Host
    #}
 
    #Write-Host
    #Write-Host "Mounting of" ("\\" + $JSON.parameters.StorageAccountName.value + ".file.core.windows.net\" + $JSON.parameters.StorageAccountShare.value) "in progress....." -ForegroundColor Red
    #Write-Host  
    New-PSDrive `
    -Name $JSON.parameters.StorageAccountShareDirve.value `
    -PSProvider FileSystem `
    -Root ("\\" + $JSON.parameters.StorageAccountName.value + ".file.core.windows.net\" + $JSON.parameters.StorageAccountShare.value) `
    -Credential $Credential
}

#$acctKey = ConvertTo-SecureString -String "qJUPDm1Nddxw5ZLCrbsFa6rwZFyq1adqeoOnBJnlEbe/qcPfiSqUaWhfYqH2PnCWXBvuaPoRu9CyBhX0r1J/nQ==" -AsPlainText -Force
#$credential = New-Object System.Management.Automation.PSCredential -ArgumentList "Azure\amsphdemisc01", $acctKey
#New-PSDrive -Name Z -PSProvider FileSystem -Root "\\amsphdemisc01.file.core.windows.net\import-csv-files" -Credential $credential -Persist