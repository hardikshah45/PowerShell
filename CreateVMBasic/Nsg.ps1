$ResourceGroupName = 'powershell-grp'
$NsgName = 'app-nsg'
$Location = 'North Europe'
$NetworkSecurityGroupName = 'app-nsg'
$VirtualNetworkName = 'app-network'
$SubnetName = 'app-subnet'
$SubnetAddressSpace = '10.0.1.0/24'

# Create the NSG Rule to allow RDP
$SecurityRule = New-AzNetworkSecurityRuleConfig -Name 'Allow-RDP' -Description 'Allow RDP'`
    -Protocol 'Tcp' -Direction 'Inbound' -Priority 100 -SourceAddressPrefix '*' -SourcePortRange '*' `
    -DestinationAddressPrefix '*' -DestinationPortRange 3389 -Access 'Allow'

# Create the NSG if it does not exist
if (Get-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Name $NsgName -ErrorAction SilentlyContinue) {
    'Network Security Group already exists'
    $nsg = Get-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Name $NsgName
    $nsg
}
else {
    'Creating the Network Security Group'
    $nsg = New-AzNetworkSecurityGroup -ResourceGroupName $ResourceGroupName -Location $Location `
    -Name $NetworkSecurityGroupName -SecurityRules $SecurityRule
}

# Associate NSG to Subnet
$vnet = Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VirtualNetworkName
$subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $vnet

$subnet | Set-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $vnet `
-NetworkSecurityGroup $nsg -AddressPrefix $SubnetAddressSpace

$vnet | Set-AzVirtualNetwork