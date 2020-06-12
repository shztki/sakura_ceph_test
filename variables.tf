variable "default_zone" {
  default = "is1a"
}

variable "def_pass" {}
variable "my_domain" {}
variable "office_cidr" {}

variable "label" {
  default = {
    namespace = "shztki"
    stage     = "dev"
    name      = "ceph"
  }
}

variable "server_add_tag" {
  default = ["@auto-reboot"]
}

variable "group_add_tag" {
  default = ["@group=a", "@group=b", "@group=c", "@group=d"]
}

variable "ssh_pubkey_path" {}
variable "sshkey" {
  default = {
    name = "test"
    memo = "example"
  }
}

variable "filter" {
  default = {
    name = "test"
    memo = "example"
  }
}

variable "disk" {
  default = {
    name      = "disk"
    size      = 20
    plan      = "ssd"    # ssd or hdd
    connector = "virtio" # virtio or ide
    memo      = "example"
  }
}

variable "disk02" {
  default = {
    name      = "disk02"
    size      = 20
    plan      = "ssd"    # ssd or hdd
    connector = "virtio" # virtio or ide
    memo      = "example"
  }
}

variable "add_disk" {
  default = {
    count     = 2
    name      = "adddisk"
    size      = 100
    plan      = "ssd"    # ssd or hdd
    connector = "virtio" # virtio or ide
    memo      = "example"
  }
}

variable "disk03" {
  default = {
    name      = "disk03"
    size      = 20
    plan      = "ssd"    # ssd or hdd
    connector = "virtio" # virtio or ide
    memo      = "example"
  }
}

variable "server" {
  default = {
    count            = 1
    core             = 2
    memory           = 4
    commitment       = "standard" # "dedicatedcpu"
    interface_driver = "virtio"
    name             = "mgr"
    memo             = "example"
  }
}

variable "server02" {
  default = {
    count            = 3
    core             = 2
    memory           = 4
    commitment       = "standard"
    interface_driver = "virtio"
    name             = "node"
    memo             = "example"
  }
}

variable "server03" {
  default = {
    count            = 1
    core             = 2
    memory           = 4
    commitment       = "standard"
    interface_driver = "virtio"
    name             = "rados"
    memo             = "example"
  }
}

variable "domain" {
  default = {
    memo = "example"
  }
}

variable "switch01" {
  default = {
    name = "192.168.200.0/24"
    memo = "example"
  }
}

variable "switch02" {
  default = {
    name = "192.168.201.0/24"
    memo = "example"
  }
}

variable "init_script" {
  default = {
    name  = "centos_init"
    class = "shell" # shell or yaml_cloud_config
    file  = "userdata/centos_init.sh"
  }
}

variable "vpc_router" {
  default = {
    name                = "test"
    memo                = "example"
    internet_connection = true
  }
}
