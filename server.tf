resource "sakuracloud_server" "server" {
  count            = var.server["count"]
  name             = format("%s-%s-%03d", module.label.id, var.server["name"], count.index + 1)
  disks            = [element(sakuracloud_disk.disk.*.id, count.index)]
  core             = var.server["core"]
  memory           = var.server["memory"]
  commitment       = var.server["commitment"]
  interface_driver = var.server["interface_driver"]

  network_interface {
    upstream = sakuracloud_switch.switch01.id
  }

  network_interface {
    upstream = sakuracloud_switch.switch02.id
  }

  disk_edit_parameter {
    ip_address      = format("192.168.200.%d", count.index + 10)
    gateway         = "192.168.200.1"
    netmask         = "24"
    hostname        = format("%s%03d.%s", var.server["name"], count.index + 1, var.my_domain)
    ssh_key_ids     = [sakuracloud_ssh_key.mykey.id]
    password        = var.def_pass
    disable_pw_auth = true
    note {
      id = sakuracloud_note.init_note.id
      variables = {
        user_name = "centos"
        eth1_ip   = format("192.168.201.%d/24", count.index + 10)
        update    = "yes"
        firewall  = "no"
      }
    }
  }

  description = format("%s%03d", var.server["memo"], count.index + 1)
  tags        = concat(var.server_add_tag, module.label.attributes, [var.group_add_tag[count.index % length(var.group_add_tag)]])
}

resource "sakuracloud_server" "server02" {
  count            = var.server02["count"]
  name             = format("%s-%s-%03d", module.label.id, var.server02["name"], count.index + 1)
  disks            = [element(sakuracloud_disk.disk02.*.id, count.index), element(sakuracloud_disk.add_disk.*.id, count.index * var.add_disk["count"]), element(sakuracloud_disk.add_disk.*.id, count.index * var.add_disk["count"] + 1)]
  core             = var.server02["core"]
  memory           = var.server02["memory"]
  commitment       = var.server02["commitment"]
  interface_driver = var.server02["interface_driver"]

  network_interface {
    upstream = sakuracloud_switch.switch01.id
  }

  network_interface {
    upstream = sakuracloud_switch.switch02.id
  }

  disk_edit_parameter {
    ip_address      = format("192.168.200.%d", count.index + 10 + var.server["count"])
    gateway         = "192.168.200.1"
    netmask         = "24"
    hostname        = format("%s%03d.%s", var.server02["name"], count.index + 1, var.my_domain)
    ssh_key_ids     = [sakuracloud_ssh_key.mykey.id]
    password        = var.def_pass
    disable_pw_auth = true
    note {
      id = sakuracloud_note.init_note.id
      variables = {
        user_name = "centos"
        eth1_ip   = format("192.168.201.%d/24", var.server["count"] + count.index + 10)
        update    = "yes"
        firewall  = "no"
      }
    }
  }

  description = format("%s%03d", var.server02["memo"], count.index + 1)
  tags        = concat(var.server_add_tag, module.label.attributes, [var.group_add_tag[count.index % length(var.group_add_tag)]])
}

resource "sakuracloud_server" "server03" {
  count            = var.server03["count"]
  name             = format("%s-%s-%03d", module.label.id, var.server03["name"], count.index + 1)
  disks            = [element(sakuracloud_disk.disk03.*.id, count.index)]
  core             = var.server03["core"]
  memory           = var.server03["memory"]
  commitment       = var.server03["commitment"]
  interface_driver = var.server03["interface_driver"]

  network_interface {
    packet_filter_id = sakuracloud_packet_filter.myfilter.id
    upstream         = "shared"
  }

  network_interface {
    upstream = sakuracloud_switch.switch01.id
  }

  disk_edit_parameter {
    hostname        = format("%s%03d.%s", var.server03["name"], count.index + 1, var.my_domain)
    ssh_key_ids     = [sakuracloud_ssh_key.mykey.id]
    password        = var.def_pass
    disable_pw_auth = true
    note {
      id = sakuracloud_note.init_note.id
      variables = {
        user_name = "centos"
        eth1_ip   = format("192.168.201.%d/24", var.server["count"] + var.server02["count"] + count.index + 10)
        update    = "yes"
        firewall  = "no"
      }
    }
  }

  description = format("%s%03d", var.server03["memo"], count.index + 1)
  tags        = concat(var.server_add_tag, module.label.attributes, [var.group_add_tag[count.index % length(var.group_add_tag)]])
}
