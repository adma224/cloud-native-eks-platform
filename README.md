Kubernetes Platform on AWS with Terraform and Secure CI/CD

Flask App on EKS – Containerized Web Application Deployment  

This project provisions an Amazon EKS cluster using Terraform and deploys a containerized web app through a GitHub Actions pipeline. It uses secure CI/CD with OpenID Connect (OIDC) and logs streaming into CloudWatch for visibility.

---

AWS Infrastructure Diagram – Project Roadmap (Currently on Phase 3)

[AWS Infrastructure Diagram](https://github.com/adma224/cloud-native-eks-platform/blob/main/diagrams/EKS-project.png) - [Project Roadmap (Currently on Phase 2)](https://github.com/adma224/cloud-native-eks-platform/wiki/Project-Roadmap)

![Architecture Diagram](https://github.com/adma224/cloud-native-eks-platform/blob/main/diagrams/EKS-project.png)

---

Overview

- VPC with two public and two private subnets across two AZs.
- NAT Gateway egress for private subnets; Internet Gateway for public.
- EKS (managed node group) ready for workloads.
- GitHub Actions → AWS via OIDC; environment-gated apply.

---

Tech Stack

Cloud Infrastructure
- **Terraform** (Infrastructure as Code)  
- **Amazon VPC** (public/private subnets, NAT, IGW)  
- **Amazon EKS** (EC2 Auto Mode)  
- **Amazon ECR** (container registry)  
- **AWS IAM** (OIDC-secured roles)  
- **Amazon CloudWatch** (logging)  

CI/CD & DevOps
- **GitHub Actions** (CI/CD with OIDC to AWS)  
- **AWS CLI** (auth & kubeconfig)  
- **Kubectl** (cluster interaction)  

Application
- **Flask** (Python web app)  
- **Docker** (containerization)  
- **Kubernetes** (Deployment, Service)  

---

Repo structure
```
.
├─ terraform/
│ ├─ backend.tf
│ ├─ providers.tf
│ ├─ variables.tf
│ ├─ outputs.tf
│ ├─ main.tf # loads ./modules/*
│ └─ modules/
│ ├─ vpc/ # VPC, subnets, IGW, NAT, routes, NACLs
│ └─ k8/ # EKS cluster, nodegroup, access entries
├─ k8s/ # (optional) app manifests
├─ .github/
│ └─ workflows/
│ └─ cd.yml # plan on push, approve to apply
├─ diagrams/
│ └─ EKS-project.png # architecture diagram
└─ README.md
```

---

Prerequisites

- Terraform ≥ 1.5
- AWS CLI v2
- kubectl
- AWS account with permissions to create IAM, VPC, EKS, and related resources

---

Configuration

**Terraform inputs** (see `terraform/variables.tf`):

| Variable               | Example                  | Notes                          |
|------------------------|--------------------------|--------------------------------|
| `project`              | `obs-eks`               | Used in naming/tags            |
| `env`                  | `dev`                   | Environment tag                |
| `region`               | `us-east-1`             | Deployment region              |
| `vpc_cidr`             | `10.0.0.0/16`           | VPC CIDR                       |
| `public_subnet_cidrs`  | `["10.0.0.0/24","10.0.1.0/24"]`   | Two public subnets   |
| `private_subnet_cidrs` | `["10.0.10.0/24","10.0.11.0/24"]` | Two private subnets  |
| `cluster_name`         | `obs-eks-dev`           | EKS cluster name               |
| Nodegroup sizing       | see `variables.tf`       | instance type, min/max/desired |

**GitHub Actions environment (`dev`) variables**:

- `AWS_ROLE_ARN` = IAM role for Actions (OIDC)
- `AWS_REGION`   = `us-east-1`

---

Quick start

Deploy (CI/CD)
- Push to `main` with changes under `terraform/`.  
- In Actions, approve the pending deployment for environment `dev`.  
- The workflow applies Terraform using OIDC.

Deploy (local, optional)
```bash
cd terraform
terraform init
terraform plan
terraform apply
```
Connect
```bash
export REGION=us-east-1
export PROJECT=obs-eks
export ENV=dev
export CLUSTER=${PROJECT}-${ENV}   # obs-eks-dev
```
```bash
aws eks update-kubeconfig --name "$CLUSTER" --region "$REGION"
kubectl config current-context
```
Validate (smoke tests)
Nodes ready
```bash
kubectl wait node --all --for=condition=Ready --timeout=10m
kubectl get nodes -o wide
```
Pod egress (public ECR image)
```bash
kubectl delete pod netcheck --ignore-not-found
kubectl run netcheck --restart=Never --image=public.ecr.aws/docker/library/busybox:latest -- sleep 3600
kubectl wait pod/netcheck --for=condition=Ready --timeout=2m
kubectl exec -it netcheck -- sh -lc 'nslookup google.com || true; wget -S --spider https://www.google.com 2>&1 | sed -n "1,12p"'
kubectl delete pod netcheck
```
OIDC (Actions → AWS)
```bash
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
aws iam get-open-id-connect-provider --open-id-connect-provider-arn "arn:aws:iam::${ACCOUNT_ID}:oidc-provider/token.actions.githubusercontent.com" --query "{Url:Url}"

# If the role name differs, adjust:
aws iam get-role --role-name GitHubActionsTerraformK8sObs --query "Role.AssumeRolePolicyDocument"
```
CI/CD summary
- Plans on push; applies only after environment approval.
- Uses AWS OIDC (no static access keys).
- Environment variables live under Settings → Environments → dev.

Cost and cleanup
NAT Gateway incurs hourly and data processing costs; stop when not needed.

Destroy:

```bash
cd terraform
terraform destroy
```
If you recreated the cluster name, clear stale EKS access entries before re-apply.

```bash
aws eks list-access-entries --cluster-name "$CLUSTER"
```
Security notes
- No long-lived AWS keys in the repo; GitHub Actions assumes an IAM role via OIDC.
- IAM policies scoped to Terraform state (S3/DynamoDB) and required network/EKS APIs.
- Default tags applied (project, env) for traceability.
