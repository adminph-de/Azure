$User = "FLS\adminph-de"
$Password = ConvertTo-SecureString "Password" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $Password
New-AzureRmAutomationCredential -AutomationAccountName "ams-aa-ph-de-t" -Name "AutomationCredential" -Value $Credential -ResourceGroupName "ams-test-ph-de"