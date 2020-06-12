# DNSゾーン参照
data "sakuracloud_dns" "dns" {
  filter {
    names = [var.my_domain]
  }
}

resource "sakuracloud_dns_record" "record_server03" {
  dns_id = data.sakuracloud_dns.dns.id
  count  = var.server03["count"]
  name   = format("%s%03d", var.server03["name"], count.index + 1)
  type   = "A"
  ttl    = 300
  value  = element(sakuracloud_server.server03.*.ip_address, count.index)
}
