locals {
  protocol         = ["ip", "tcp", "udp", "fragment", "ip"]
  source_network   = [var.office_cidr, "", "", "", ""]
  source_port      = ["", "", "", "", ""]
  destination_port = ["", "32768-61000", "32768-61000", "", ""]
  allow            = [true, true, true, true, false]
}

resource "sakuracloud_packet_filter" "myfilter" {
  name        = module.label.id
  description = var.filter["memo"]

  dynamic "expression" {
    for_each = local.protocol
    content {
      protocol         = local.protocol[expression.key]
      source_network   = local.source_network[expression.key]
      source_port      = local.source_port[expression.key]
      destination_port = local.destination_port[expression.key]
      allow            = local.allow[expression.key]
    }
  }
}
