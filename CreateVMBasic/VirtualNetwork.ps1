$ResourceGroupName = 'powershell-grp'
$Location = 'North Europe'

$VirtualNetworkName = 'app-network'
$VirtualNetworkAddressSpace = '10.0.0.0/16'
$SubnetName = 'app-subnet'
$SubnetAddressSpace = '10.0.1.0/24'

# Create the subnet resource
$SubnetA = New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressSpace

# Create the virtual network resource
if (Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VirtualNetworkName -ErrorAction SilentlyContinue) {
    'Virtual Network already exists'
    $vnet = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VirtualNetworkName
    $vnet
}
else {
    'Creating the Virtual Network'
    $vnet = New-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Location $Location `
    -Name $VirtualNetworkName -AddressPrefix $VirtualNetworkAddressSpace -Subnet $SubnetA
}