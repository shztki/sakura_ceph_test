resource "sakuracloud_vpc_router" "vpc_router" {
  name        = module.label.id
  description = var.vpc_router["memo"]
  tags        = module.label.attributes
  plan        = "standard"

  internet_connection = var.vpc_router["internet_connection"]

  private_network_interface {
    index        = 1
    switch_id    = sakuracloud_switch.switch01.id
    ip_addresses = ["192.168.200.1"]
    netmask      = 24
  }

  # ポートフォワード
  port_forwarding {
    protocol     = "tcp"
    public_port  = 10022
    private_ip   = "192.168.200.10"
    private_port = 22
    description  = "desc"
  }
  port_forwarding {
    protocol     = "tcp"
    public_port  = 8443
    private_ip   = "192.168.200.10"
    private_port = 8443
    description  = "desc"
  }
  port_forwarding {
    protocol     = "tcp"
    public_port  = 3000
    private_ip   = "192.168.200.10"
    private_port = 3000
    description  = "desc"
  }

  firewall {
    interface_index = 1

    direction = "send"
    expression {
      protocol            = "ip"
      source_network      = var.office_cidr
      source_port         = ""
      destination_network = ""
      destination_port    = ""
      allow               = true
      logging             = true
      description         = "desc"
    }

    expression {
      protocol            = "ip"
      source_network      = ""
      source_port         = ""
      destination_network = ""
      destination_port    = ""
      allow               = false
      logging             = true
      description         = "desc"
    }
  }
}
