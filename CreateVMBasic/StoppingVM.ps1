$VMName = 'appvm01'
$ResourceGroupName = 'powershell-grp'

$Statuses = (Get-AzVm -ResourceGroupName $ResourceGroupName -Name $VMName -Status).Statuses

if($Statuses[1].Code -eq 'PowerState/running') {
    'Shutdown the Vm'
    Stop-AzVM -ResourceGroupName $ResourceGroupName -Name $VMName -Force
} else {
    'The machine is not in running state.'
}