$VMName = 'appvm01'
$ResourceGroupName = 'powershell-grp'
$DesiredVMSize = 'Standard_D4s_v5'

$Vm = Get-AzVm -ResourceGroupName $ResourceGroupName -Name $VMName

if ($Vm.HardwareProfile.VmSize -ne $DesiredVMSize) {
    $Vm.HardwareProfile.VmSize = $DesiredVMSize
    $Vm | Update-AzVM
} else {
    'Desired size is same as the VM size'
}

