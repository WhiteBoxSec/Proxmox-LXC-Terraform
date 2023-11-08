terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">= 2.0.0"
    }
  }
}

variable "proxmox_api_url" {
  description = "The API URL for the Proxmox provider."
  type = string
}

variable "proxmox_api_token" {
  description = "The API token for Proxmox."
  type = string
}

variable "proxmox_api_secret" {
  description = "The API secret for Proxmox."
  type = string
}

variable "proxmox_username" {
  description = "The user for the Proxmox provider."
  type = string
}

# not needed if using API token
variable "proxmox_password" {
  description = "The password for the Proxmox provider."
  type = string
  sensitive = true
}

variable "proxmox_tls_insecure" {
  description = "Whether to disable TLS verification for the Proxmox provider."
  type = bool
}

variable "user_password" {
  description = "The password for the LXC user."
  type = string
  sensitive = true
}

variable "storage" {
  description = "The storage to use for the containers."
  type = string
}

variable "name_prefix" {
  description = "The prefix for the name of the containers."
  type = string
}

variable "client_name" {
  description = "Name of client."
  type = string
}

variable "node" {
  description = "The node where you want the containers to be created at."
  type = string
}

variable "container_count" {
  description = "The number of containers to create."
  type = number
}

variable "template" {
  description = "The template to use for creating the containers."
  type = string
}

variable "memory" {
  description = "The amount of memory for the containers."
  type = number
}

variable "cores" {
  description = "The number of cores for the containers."
  type = number
}

variable "disk_size" {
  description = "The disk size for the containers."
  type = string
}

variable "network_bridge" {
  description = "The network bridge for the containers."
  type = string
}

variable "network_ipv4" {
  description = "The IPv4 address for the containers."
  type = string
}

variable "ssh_keys" {
  description = "The SSH keys to use for the VMs."
  type = string
}

provider "proxmox" {
  pm_api_url      = var.proxmox_api_url
  pm_user         = var.proxmox_username
  # optional password auth
  #pm_password     = var.proxmox_password
  pm_tls_insecure = var.proxmox_tls_insecure
  pm_api_token_id = var.proxmox_api_token
  pm_api_token_secret = var.proxmox_api_secret
}

resource "proxmox_lxc" "example_container" {
  description  = "${var.name_prefix} for ${var.client_name} IP=${var.network_ipv4}"
  count        = var.container_count
  hostname     = "${var.name_prefix}-${var.client_name}"
  ostemplate   = var.template
  unprivileged = true
  target_node  = var.node
  memory       = var.memory
  cores        = var.cores
  password     = var.user_password
  onboot       = true
  ostype = "l26"
  
  #hastate      = "started"
  ssh_public_keys = var.ssh_keys
  
  # change to specific 
  # vmid = 20"${count}"

  rootfs {
    storage = var.storage
    size    = var.disk_size
  }
  
  # Option to set DNS server
  # nameserver = "10.50.50.3"
  
  network {
    name  = "eth0"
    bridge   = var.network_bridge
    ip     = var.network_ipv4
    ip6     = "auto"
    firewall = true
    #optional VLAN tag
    #tag = 99
  }
}