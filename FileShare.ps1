$AccountName = 'psstorageacc0623'
$ResourceGroupName = 'powershell-grp'

$storageAccount = Get-AzStorageAccount -Name $AccountName -ResourceGroupName $ResourceGroupName

$FileShareConfig = @{
    Context = $storageAccount.Context
    Name = 'data'
}

New-AzStorageShare @FileShareConfig

$DirectoryDetails=@{
    Context = $storageAccount.Context
    ShareName = 'data'
    Path = 'files'
}

New-AzStorageDirectory @DirectoryDetails

$FileDetails = @{
    Context = $storageAccount.Context
    ShareName = 'data'
    Source = '.\Sample.txt'
    Path = '/files/sample.txt'

}

Set-AzStorageFileContent @FileDetails