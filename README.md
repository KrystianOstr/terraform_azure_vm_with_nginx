## Project Overview

This project demonstrates the integration of Terraform and Ansible within a CI/CD pipeline on GitHub Actions.

The pipeline runs in two stages:

**Terraform job** – provisions basic infrastructure on Azure:

- Resource Group

- Virtual Network + Subnet

- Network Security Group (rules for 22/80/443)

- Public IP

- Network Interface

- Linux Virtual Machine (Ubuntu 22.04) with SSH login (key-based)

- Remote state stored in Azure Storage

At the end of the job, the VM’s public IP is exposed as an output.

**Ansible job** – runs after Terraform:

- connects to the newly created VM over SSH,

- installs Nginx,

- copies a static index.html,

- ensures the service is running.

Result: after the workflow completes, you can open http://<PUBLIC_IP> and see a static page with your header.

### Requirements

- An Azure account
  
- Configured backend (Azure Storage + container for tfstate)

### GitHub Secrets

Set the following secrets in your repository (Settings → Secrets and variables → Actions → New repository secret):

| Secret | Description |
|-----------|-----------|
| AZURE_SUBSCRIPTION_ID | Your Azure subscription ID |
| AZURE_TENANT_ID | Tenant ID from AAD |
| AZURE_CLIENT_ID | ID of the Service Principal used for OIDC |
| SSH_PRIVATE_KEY | Private SSH key (~/.ssh/id_ed25519 or similar) |

The public key is derived from SSH_PRIVATE_KEY inside the workflow and passed to Terraform as TF_VAR_ssh_pub_key.


### Repository Structure
```
.
├── infra/
│   ├── main.tf          # RG, VNet, Subnet, NSG, PIP, NIC, VM
│   ├── variables.tf     # Variables
│   ├── outputs.tf       # public_ip
│   └── backend.tf       # AzureRM remote state
├── config/
│   └── ansible/
│       ├── site.yml     # Playbook: nginx + index.html
│       └── files/
│           └── index.html
└── .github/
    └── workflows/
        └── infra.yml    # Terraform + Ansible pipeline
```

### How to Run

1. Fork the repository.

2. Create in Azure: Resource Group + Storage Account + Container for tfstate.
Update infra/backend.tf with your own values (resource_group_name, storage_account_name, container_name).

3. Set the required GitHub Secrets (AZURE_*, SSH_PRIVATE_KEY).

4. Go to the Actions tab and run the workflow manually or push to the main branch.

5. Once the pipeline finishes, check the Terraform job logs for public_ip.

6. Open in your browser:

`http://<PUBLIC_IP>`
