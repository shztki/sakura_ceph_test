output "vpc_router_ip" {
  value = sakuracloud_vpc_router.vpc_router.public_ip
}

output "server03_ip" {
  value = sakuracloud_server.server03.*.ip_address
}