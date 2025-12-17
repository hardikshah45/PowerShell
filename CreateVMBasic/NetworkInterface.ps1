$ResourceGroupName = 'powershell-grp'
$VirtualNetworkName = 'app-network'
$SubnetName = 'app-subnet'

$VirtualNetwork = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VirtualNetworkName
$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork

$NetworkInterfaceName = 'app-nic'
$Location = 'North Europe'

# Create the network interface resource
if (Get-AzNetworkInterface -ResourceGroupName $ResourceGroupName -Name $NetworkInterfaceName -ErrorAction SilentlyContinue) {
    'Network Interface already exists'
    $nic = Get-AzNetworkInterface -ResourceGroupName $ResourceGroupName -Name $NetworkInterfaceName
    $nic
}
else {
    'Creating the Network Interface'
    $nic = New-AzNetworkInterface -ResourceGroupName $ResourceGroupName -Location $Location `
    -Name $NetworkInterfaceName -Subnet $Subnet
}