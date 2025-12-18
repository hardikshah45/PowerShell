$VMName = 'appvm01'
$ResourceGroupName = 'powershell-grp'

$Vm = Get-AzVm -ResourceGroupName $ResourceGroupName -Name $VMName

'Deleting the datadisk'

foreach($Datadisk in $Vm.StorageProfile.DataDisks) {
    'Removing Data disk ' + $Datadisk.Name

    Remove-AzVmDataDisk -VM $Vm -DataDiskNames $Datadisk.Name
    $Vm | Update-AzVM

    Get-AzDisk -ResourceGroupName $ResourceGroupName -DiskName $Datadisk.Name | Remove-AzDisk -Force
}

'Deleting Public Ip Address'

foreach($Interfaces in $Vm.NetworkProfile.NetworkInterfaces) {

    $NetWorkInterface = Get-AzNetworkInterface -ResourceId $Interfaces.Id

    $PublicIpAddres = Get-AzResource -ResourceId $NetWorkInterface.IpConfigurations.publicIpAddress.Id

    $NetWorkInterface.IpConfigurations.publicIpAddress.Id = $null
    $NetWorkInterface | Set-AzNetworkInterface

    'Removing Public Ip Address' + $PublicIpAddres.Name
    Remove-AzPublicIpAddress -ResourceGroupName $ResourceGroupName -Name $PublicIpAddres.Name -Force
}

'Get a handle to the OS Disk'
$OsDisk = $Vm.StorageProfile.OsDisk

'Deleting the Virtual Machine'

Remove-AzVM -Name $VMName -ResourceGroupName $ResourceGroupName -Force

'Deleting the NetworkInterface'

$NetWorkInterface | Remove-AzNetworkInterface -Force

'Deleting the OSDisk'

Get-AzDisk -ResourceGroupName $ResourceGroupName -Name $OsDisk.Name | Remove-AzDisk -Force