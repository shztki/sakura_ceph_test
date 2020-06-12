resource "sakuracloud_ssh_key" "mykey" {
  name        = module.label.id
  public_key  = file(var.ssh_pubkey_path)
  description = var.sshkey["memo"]
}
