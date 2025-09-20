# Node.js App Deployment with Terraform & Ansible

Deploy a Node.js application on AWS EC2 using Terraform for infrastructure and Ansible for application deployment.

> **Note:** The Node.js application code is in a separate repository and will be automatically cloned during deployment.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) installed
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) installed  
- AWS account with configured credentials
- AWS key pair (.pem file)
- Git installed

## Setup Instructions

### 1. Clone Repository
```bash
git clone https://github.com/<username>/nodejs-app-deployment.git
cd nodejs-app-deployment
```

### 2. Configure Ansible Inventory
Edit `ansible/inventory.ini`:
```ini
[ec2]
ubuntu@<PUBLIC_IP> ansible_ssh_private_key_file=/path/to/your/key.pem ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```
**⚠️ Do NOT commit your .pem file to version control**

### 3. Deploy Infrastructure
```bash
cd terraform
terraform init
terraform plan
terraform apply
```
Type `yes` when prompted.

### 4. Deploy Application  
```bash
cd ../ansible
ansible-playbook -i inventory.ini playbook.yml
```

### 5. Access Application
Navigate to: `http://<PUBLIC_IP>:3007`

## Deployment Screenshots

### Ansible Deployment
![WhatsApp Image 2025-09-20 at 21 12 36_8fdb2318](https://github.com/user-attachments/assets/47ba6c25-93d1-4564-b789-3022cf62f212)

### Application Running
![WhatsApp Image 2025-09-20 at 21 16 43_c0874180](https://github.com/user-attachments/assets/51d7b144-6fc6-4989-8eab-d1fbb75b0f24)

## Project Structure
```
nodejs-app-deployment/
├── terraform/           # Infrastructure code
├── ansible/            # Configuration & deployment
│   ├── inventory.ini   # Server details
│   └── playbook.yml    # Deployment tasks
└── README.md
```

## Configuration

Update variables directly in your Terraform files as needed for your specific AWS setup.

## Troubleshooting

**SSH Connection Issues:**
- Check .pem file path in inventory.ini
- Set correct permissions: `chmod 400 your-key.pem`
- Verify EC2 instance is running

**Terraform Errors:**
- Confirm AWS credentials are configured
- Ensure key pair exists in specified region
- Check AWS permissions

**Application Not Loading:**
- Verify security group allows port 3007
- Check public IP address
- SSH to instance and verify app status

## Cleanup
```bash
cd terraform
terraform destroy
```

## Commands Reference

| Action | Command |
|--------|---------|
| Deploy infrastructure | `terraform apply` |
| Deploy application | `ansible-playbook -i inventory.ini playbook.yml` |
| Destroy infrastructure | `terraform destroy` |
| Debug Ansible | `ansible-playbook -i inventory.ini playbook.yml -vvv` |
