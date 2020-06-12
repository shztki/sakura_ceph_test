resource "sakuracloud_note" "init_note" {
  name    = format("%s_%s", module.label.id, var.init_script["name"])
  class   = var.init_script["class"]
  content = file(var.init_script["file"])
  tags    = module.label.attributes
}