$AccountName = 'psstorageacc0623'
$AccountKind = 'StorageV2'
$AccountSKU = 'Standard_LRS'
$ResourceGroupName = 'powershell-grp'
$Location = 'North Europe'

$ContainerName = 'data'

# Check for the existence of the storage account. 
if (Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $AccountName -ErrorAction SilentlyContinue ) {
    'Storage Account already exists'
    $storageAccount = Get-AzStorageAccount -Name $AccountName -ResourceGroupName $ResourceGroupName
}
else {
    'Creating the storage Account'
    $storageAccount = New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $AccountName -Kind $AccountKind `
    -Location $Location -SkuName $AccountSKU
}

# Check for the existence for the storage account container. 
if (Get-AzStorageContainer -Name $ContainerName -Context $storageAccount.Context -ErrorAction SilentlyContinue) {
    'Storage Account container already exist'
    $Container = Get-AzStorageContainer -Name $ContainerName -Context $storageAccount.Context
    $Container
}
else {
    'Creating the container'
    $Container = New-AzStorageContainer -Name $ContainerName -Context $storageAccount.Context -Permission Blob
}

$BlobObject =@{
    FileLocation='.\Sample.txt'
    ObjectName = 'Sample.txt'
}

# Check if the Blob content already exists. 
if (Get-AzStorageBlob -Context $storageAccount.Context -Container $ContainerName -ErrorAction SilentlyContinue) {
    'Blob does exist'
    $Blob = Get-AzStorageBlob -Context $storageAccount.Context -Container $ContainerName
    $Blob
}
else {
    'Creating the Blob'
    $Blob = Set-AzStorageBlobContent -Context $storageAccount.Context -Container $ContainerName `
    -File $BlobObject.FileLocation -Blob $BlobObject.ObjectName
}

