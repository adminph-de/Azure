#VNet main settings
variable "vnet-location" {   
  description = "Location of the network"    
  default     = "westeurope"
}
variable "vnet-resource-group" { 
  description = "Resource Groupe Name"
  default     = "ams-test-core-network-t"
}
variable "vnet-name" {      
  description = "VNet Name"     
  default     = "ams-spoke-10-vnet-t"
}
variable "vnet-address-space" {
  description = "VNet Address Space"
  default     = "192.168.150.0/24"
}
variable "vnet-dns-servers" {
  description = "Customized DNS Servers of the VNet"
  default     = ["10.31.0.192", "8.8.8.8"]
}
#Default Subnet definition
variable "default-name" {    
  description = "Default Network Name for VMs etc."    
  default     = "default__192_168_150_128__25"
}
variable "default-subnet" {   
  description = "Address scope for the default Network"  
  default     = "192.168.150.128/25"
}

#Bastion Host Settings
variable "bastion-host-name" {   
  description = "Hostname of the Bastian Host (allign with the VNet Name)"
  default     = "ams-spoke-10-bastion-t"
}
variable "bastion-subnet" {     
  description = "Scope for the Bastion Subnet (smalles possible /26)" 
  default     = "192.168.150.64/26"
}

