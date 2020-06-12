resource "sakuracloud_disk" "disk" {
  count             = var.server["count"]
  name              = format("%s-%s-%03d", module.label.id, var.disk["name"], count.index + 1)
  source_archive_id = data.sakuracloud_archive.centos8.id
  plan              = var.disk["plan"]
  connector         = var.disk["connector"]
  size              = var.disk["size"]
  tags              = module.label.attributes
  description       = format("%s%03d", var.disk["memo"], count.index + 1)
}

resource "sakuracloud_disk" "disk02" {
  count             = var.server02["count"]
  name              = format("%s-%s-%03d", module.label.id, var.disk02["name"], count.index + 1)
  source_archive_id = data.sakuracloud_archive.centos8.id
  plan              = var.disk02["plan"]
  connector         = var.disk02["connector"]
  size              = var.disk02["size"]
  tags              = module.label.attributes
  description       = format("%s%03d", var.disk02["memo"], count.index + 1)
}

resource "sakuracloud_disk" "add_disk" {
  count       = var.server02["count"] * var.add_disk["count"]
  name        = format("%s-%s-%03d", module.label.id, var.add_disk["name"], count.index + 1)
  plan        = var.add_disk["plan"]
  connector   = var.add_disk["connector"]
  size        = var.add_disk["size"]
  tags        = module.label.attributes
  description = format("%s-%03d", var.add_disk["memo"], count.index + 1)
}

resource "sakuracloud_disk" "disk03" {
  count             = var.server03["count"]
  name              = format("%s-%s-%03d", module.label.id, var.disk03["name"], count.index + 1)
  source_archive_id = data.sakuracloud_archive.centos8.id
  plan              = var.disk03["plan"]
  connector         = var.disk03["connector"]
  size              = var.disk03["size"]
  tags              = module.label.attributes
  description       = format("%s%03d", var.disk03["memo"], count.index + 1)
}
