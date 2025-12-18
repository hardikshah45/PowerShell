$VMName = 'appvm01'
$ResourceGroupName = 'powershell-grp'
$DiskName = 'app-disk'

$Vm = Get-AzVm -ResourceGroupName $ResourceGroupName -Name $VMName

$Vm | Add-AzVMDataDisk -Name $DiskName -DiskSizeInGB 16 -CreateOption Empty -Lun 0

$Vm | Update-AzVM 