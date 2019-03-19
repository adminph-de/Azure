#Create the VM
$vnetName = 'ams-vnet-1'
$vnetResourceGroupe = 'ams-core-network'
$nicName = 'ams-k2-rdp01-p_nic0'
$vmName = "ams-k2-rdp01-p"
$vmSize = "Standard_A2"

$SingleSubnet = Get-AzureRmVirtualNetwork -ResourceGroupName $vnetResourceGroupe -Name $vnetName | Get-AzureRmVirtualNetworkSubnetConfig

$vnet =  Get-AzureRmVirtualNetwork -name $vnetName -ResourceGroupName $vnetResourceGroupe

$nic = New-AzureRmNetworkInterface -Name $nicName `
   -ResourceGroupName $destinationResourceGroup `
   -Location $location -SubnetId $vnet.Subnets[4].Id `
   -PublicIpAddressId $pip.Id `
   -NetworkSecurityGroupId $nsg.Id


$vmConfig = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize 

$vm = Add-AzureRmVMNetworkInterface -VM $vmConfig -Id $nic.Id
$vm = Set-AzureRmVMOSDisk -VM $vm -ManagedDiskId $osDisk.Id -StorageAccountType Standard_LRS `
    -DiskSizeInGB 128 -CreateOption Attach -Windows

New-AzureRmVM -ResourceGroupName $destinationResourceGroup -Location $location -VM $vm