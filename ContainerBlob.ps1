$AccountName = 'appstore06231704'
$ResourceGroupName = 'powershell-grp'

$ContainerName = 'data'

$storageAccount = New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $AccountName

New-AzStorageContainer -Name $ContainerName -Context $storageAccount.Context -Permission Blob

$BlobObject =@{
    FileLocation='.\Sample.txt'
    ObjectName = 'Sample.txt'
}

Set-AzStorageBlobContent -Context $storageAccount.Context -Container $ContainerName `
-File $BlobObject.FileLocation -Blob $BlobObject.ObjectName