$VMName = 'appvm01'
$ResourceGroupName = 'powershell-grp'
$Location = 'North Europe'
$VMSize = 'Standard_D2s_v5'

$Credential = Get-Credential -Message "Enter the username and password for the VM."

# Get the network interface
$NetworkInterfaceName = 'app-nic'
$nic = Get-AzNetworkInterface -ResourceGroupName $ResourceGroupName -Name $NetworkInterfaceName

$VmConfig = New-AzVMConfig -VMName $VMName -VMSize $VMSize

Set-AzVMOperatingSystem -Windows -ComputerName $VMName -Credential $Credential -VM $VmConfig

Set-AzVMSourceImage -PublisherName 'MicrosoftWindowsServer' -Offer 'WindowsServer' -Skus '2019-Datacenter'`
 -Version 'latest' -VM $VmConfig

$vm = Add-AzVMNetworkInterface -Id $nic.Id -VM $VmConfig

Set-AzVMBootDiagnostic -Disable -VM $vm

New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $vm
'Virtual Machine created successfully.'
