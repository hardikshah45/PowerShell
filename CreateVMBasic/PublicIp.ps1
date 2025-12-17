$PublicIpAddressName = 'app-publicip'
$ResourceGroupName = 'powershell-grp'
$Location = 'North Europe'

$PublicIpAddress = New-AzPublicIpAddress -Name $PublicIpAddressName -ResourceGroupName $ResourceGroupName `
    -Location $Location -AllocationMethod "Static" -Sku "Standard"

# Get the details of network interface to associate public IP
$NetworkInterfaceName = 'app-nic'
$nic = Get-AzNetworkInterface -ResourceGroupName $ResourceGroupName -Name $NetworkInterfaceName

$IpConfig = Get-AzNetworkInterfaceIpConfig -NetworkInterface $nic

$nic | Set-AzNetworkInterfaceIpConfig -Name $IpConfig.Name -PublicIpAddress $PublicIpAddress

$nic | Set-AzNetworkInterface
'Public IP Address associated with Network Interface successfully.'
