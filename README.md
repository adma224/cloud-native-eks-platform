# Kubernetes Platform on AWS with Terraform and Secure CI/CD

Flask App on EKS – Containerized Web Application Deployment  

This project provisions an Amazon EKS cluster using Terraform and deploys a containerized web app through a GitHub Actions pipeline. It uses secure CI/CD with OpenID Connect (OIDC) and logs streaming into CloudWatch for visibility.

---

## AWS Infrastructure Diagram – Project Roadmap (Currently on Phase 3)

[AWS Infrastructure Diagram](https://github.com/adma224/cloud-native-eks-platform/blob/main/diagrams/EKS-project.png) - [Project Roadmap (Currently on Phase 2)](https://github.com/adma224/cloud-native-eks-platform/wiki/Project-Roadmap)

![Architecture Diagram](https://github.com/adma224/cloud-native-eks-platform/blob/main/diagrams/EKS-project.png)

---

## Project Goals
- Provision reproducible AWS infrastructure using Terraform (VPC + EKS).  
- Implement secure GitHub Actions CI/CD with OIDC (no long-lived AWS keys).  
- Build, containerize, and push a Flask app image to Amazon ECR.  
- Deploy the Flask app to EKS via Kubernetes manifests.  
- Enable CloudWatch logging for the application.  
- Provide a documented, demo-ready workflow (PR → Plan → Merge → Apply).  

---

## Tech Stack

### Cloud Infrastructure
- **Terraform** (Infrastructure as Code)  
- **Amazon VPC** (public/private subnets, NAT, IGW)  
- **Amazon EKS** (EC2 Auto Mode)  
- **Amazon ECR** (container registry)  
- **AWS IAM** (OIDC-secured roles)  
- **Amazon CloudWatch** (logging)  

### CI/CD & DevOps
- **GitHub Actions** (CI/CD with OIDC to AWS)  
- **AWS CLI** (auth & kubeconfig)  
- **Kubectl** (cluster interaction)  

### Application
- **Flask** (Python web app)  
- **Docker** (containerization)  
- **Kubernetes** (Deployment, Service)  

---

## Phase Roadmap
- **Phase 0:** GitHub Actions CI/CD + Terraform backend (S3 + DynamoDB) + VPC networking.  
- **Phase 1:** Amazon EKS cluster provisioned with Terraform; OIDC enabled for IRSA.  
- **Phase 2:** Kubernetes base setup; namespaces, RBAC, and kube-state-metrics/node-exporter.  
- **Phase 3 (current):** Flask app containerized, built with CI, pushed to ECR, and deployed on EKS.  

---

## Validate local kubectl access

**Prereqs:** AWS CLI v2 and kubectl installed; your IAM principal granted cluster access (EKS → Access → ClusterAdmin).

```bash
# Configure kubeconfig for this cluster
aws eks update-kubeconfig --region us-east-1 --name obs-eks-dev

# Confirm connectivity to the API
kubectl cluster-info

# Verify worker nodes are Ready (should be 2)
kubectl wait node --all --for=condition=Ready --timeout=10m
kubectl get nodes -o wide
