# Terraform + Ansible Project

Infrastructure provisioning with Terraform (Azure) and configuration management with Ansible.

## Structure

- `terraform/` — Azure infrastructure (VMs, networking, storage)
- `ansible/` — Playbooks and roles to configure the provisioned hosts

## Prerequisites

Set these environment variables before running:

```bash
export ARM_SUBSCRIPTION_ID="<your-azure-subscription-id>"
export TF_VAR_admin_password="<windows-admin-password>"
export TF_VAR_db_admin_password="<postgres-admin-password>"
export WIN_PASSWORD="<windows-admin-password>"
```

## Usage

### Terraform

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Ansible

```bash
cd ansible
ansible-galaxy install -r requirements.yml
ansible-playbook n01017431-playbook.yml
```
