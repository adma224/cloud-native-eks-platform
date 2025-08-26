# Terraform-Driven Kubernetes Platform on AWS with Secure CI/CD

Flask App on EKS – Containerized Web Application Deployment  
This project provisions a production-style Amazon EKS cluster using Terraform and deploys a containerized Flask web app through a GitHub Actions pipeline. It demonstrates secure CI/CD with OpenID Connect (OIDC), automated VPC networking, and application delivery with Kubernetes, with logs streaming into CloudWatch for visibility.

---

## Project Description
This project showcases a production-style Kubernetes infrastructure built on AWS, emphasizing automation and security. A fully automated Terraform setup provisions the VPC (public/private subnets, NAT, IGW) and an Amazon EKS cluster in EC2 Auto Mode. The CI/CD pipeline, powered by GitHub Actions and OIDC, securely assumes AWS roles without long-lived credentials.  

The platform demonstrates containerized application delivery: a Flask web app is built, pushed to Amazon ECR, and deployed onto EKS with Kubernetes manifests. The cluster is network-ready for real-world workloads, with application logs available in Amazon CloudWatch for inspection and debugging.

---

## AWS Infrastructure Diagram – Project Roadmap (Currently on Phase 3)



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
