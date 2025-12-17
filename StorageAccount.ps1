$AccountName = 'appstore06231704'
$AccountKind = 'StorageV2'
$AccountSKU = 'Standard_LRS'
$ResourceGroupName = 'powershell-grp'
$Location = 'North Europe'

Set-AzContext -Subscription "17ef4916-0252-4ab8-91a6-e9f6446c02d2"

$storageAccount = New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $AccountName -Kind $AccountKind `
-Location $Location -SkuName $AccountSKU

$storageAccount
