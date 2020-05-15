# Terraforming with AWS
Terraform scripts that will provsion an EC2 instance running Ubuntu behind an ELB.

## Resources

After running Terraform, the following resources will be provsioned:

- EC2 Instance
- Elastic Load Balancer
- Security Groups
- Launch Configuration
- Autoscaling Policy
- CloudWatch metric alarms
- VPC
- Subnets
- Routing table with associations
- Internet Gateway
  
## Prerequisites

Please ensure the following are created or installed before continuing:

- **Terraform**
  - Version 0.12 or above
  - Run `terraform init` in the same folder Git is initialized in
- **Git**
  - Set up credentials
  - Run `git init` in the same folder Terraform is initialized in
- **AWS IAM User with AdministratorAccess policy***
- **Generate a public and private key pair called "keypair"***


**NOTE** | 
-----|
While using a AWS IAM User with full administrator access helps to avoid permission issues during deployment, please note that this does not follow the principle of least privilege. Using an IAM User with only the permissions needed to provision the resources you want is the most recommended practice.

**NOTE** |
---------|
For help with generating SSH keys, please refer to the following documentation:
Windows: https://docs.joyent.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-windows
Linux/MacOS: https://docs.joyent.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-mac-os-x

## Instructions

1. Run `git pull https://github.com/DrWalrusMD/TerraformingWithAWS.git` in the same folder Terraform and Git are initialized in
2. Place the generated SSH keys "keypair" and "keypair.pub" in the same folder that `git pull` was ran
3. Set Environment Variables with the Access and Secret Access keys for the AWS IAM User being used

 Linx/MacOS:
  
    export AWS_ACCESS_KEY_ID=
    export AWS_SECRET_ACCESS_KEY=
  
      
  Windows:
  
    set AWS_ACCESS_KEY_ID=
    set AWS_SECRET_ACCESS_KEY=
  
4. Run `terraform apply -auto-approve`
5. After the resources are provisioned, access the static website through the ELB's address.
