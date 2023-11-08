# Proxmox-Terraform-LXC
Terraform template for creating Debian LXC container in Proxmox. 

This is for a Debian 12 LXC container in Proxmox.

## Usage

Add your credentials to the variables file.

How to create a new user and API key.

https://registry.terraform.io/providers/Telmate/proxmox/latest/docs

Username and password auth works too. Uncomment the lines in the files and comment out the API ones. 


Plan the LXC container.
```
terraform plan -out lxc-test
```

Apply the plan.
```
terraform apply lxc-test
```

Destory the container.
```
terraform destory
```

