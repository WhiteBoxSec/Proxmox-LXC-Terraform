# Proxmox API configuration
proxmox_api_url      = "https://10.50.50.227:8006/api2/json"  # Proxmox IP or hostname
proxmox_username     = "user@pve!user"
proxmox_password     = "N/A" # Not needed if using API Token
proxmox_api_token      = "user@pve!user" # Not needed if using password
proxmox_api_secret      = "XXXX-XXXX-XXXX-XXXX-XXXX" # Same
proxmox_tls_insecure = "true"

# Container configuration
container_count = 1
name_prefix = "Test-Container"
# Client name 
client_name = "Client-A"

# The template must be downloaded ahead of time.
template = "local:vztmpl/debian-12-standard_12.2-1_amd64.tar.zst"
storage = "local-lvm"
# Must be at least 4 characters
user_password = "testpassword"
ssh_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAXXXXXXXXXX"

# Resource allocation
cores = 2
disk_size = "40G"
memory = 4096

# Network configuration
network_bridge = "vmbr0"
network_ipv4 = "dhcp"

# Node
node = "PVE-Node-1"