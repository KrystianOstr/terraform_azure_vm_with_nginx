output "pub_ip" {
  value = azurerm_public_ip.pubip.ip_address
}

output "ssh_command" {
  value = "ssh -i ../.ssh/kryst-ed25519.pub ${azurerm_linux_virtual_machine.web_vm.admin_username}@${azurerm_linux_virtual_machine.web_vm.public_ip_address}"
}