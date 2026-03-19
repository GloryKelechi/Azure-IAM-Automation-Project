# Azure IAM Infrastructure Automation

A DevOps project demonstrating **Infrastructure as Code (IaC)** and **CI/CD** pipelines to deploy a secure, partitioned Azure network with specific Identity and Access Management (IAM) controls.

## 🚀 Project Overview
This repository automates the deployment of a secure Azure environment. It uses a Bash script for resource creation and a GitHub Actions workflow to ensure that any changes to the infrastructure are automatically applied to the Azure cloud.

### Key Features
* **Automated Resource Deployment:** Creates Resource Groups, Virtual Networks, and Subnets via Azure CLI.
* **RBAC Implementation:** Automatically creates Entra ID (Active Directory) groups and assigns "Least Privilege" roles to specific subnets.
* **CI/CD Pipeline:** Integrated with GitHub Actions for automated deployment upon code push.
* **Secure Credential Management:** Uses GitHub Secrets to store Azure Service Principal credentials.

## 🏗 Architecture
The infrastructure consists of:
1.  **Resource Group:** \`Glory-Secure-RG\`
2.  **Virtual Network:** \`SecureVeeNet\` (10.0.0.0/16)
3.  **Subnets:**
    * \`WebSubNet\` (10.0.1.0/24) - For web-tier resources.
    * \`DBSubNet\` (10.0.2.0/24) - For database-tier resources.
4.  **IAM Roles:**
    * \`WebAdmins\` Group: Granted access to manage web resources.
    * \`DBAdmins\` Group: Granted **Reader** access specifically to the \`DBSubNet\`.

## 🛠 Tech Stack
* **Cloud Provider:** Microsoft Azure
* **Automation:** Bash (Azure CLI)
* **CI/CD:** GitHub Actions
* **Version Control:** Git

## 📋 Prerequisites
* An active Azure Subscription.
* A GitHub account.
* A Service Principal with \`Contributor\` permissions at the subscription level.

## ⚙️ Configuration
### GitHub Secrets
To run this pipeline, the following secret must be added to the GitHub repository:
* \`AZURE_CREDENTIALS\`: The JSON object generated via the Azure CLI.

## 🚀 How to Deploy
1. Push changes to the \`master\` branch:
    \`\`\`bash
    git add .
    git commit -m "Updating documentation"
    git push origin master
    \`\`\`
2. Monitor progress in the **Actions** tab of the GitHub repository.

## 🛡 Security Best Practices
* **Principle of Least Privilege (PoLP):** Roles are assigned at the Subnet level.
* **Secret Masking:** Credentials are encrypted in GitHub Secrets.
