# AWS EKS Application Platform

A production-style reference platform built on **Amazon EKS** using **Terraform** for infrastructure, **GitHub Actions** for CI/CD, and **CloudWatch** for observability.  
This project demonstrates how to provision a secure EKS cluster, deploy a containerized frontend, expose it publicly, and monitor costs and performance — following real-world practices.

---

## 📌 Overview

**Core features**
- **Infrastructure as Code (Terraform):** VPC, EKS cluster, managed node groups, cost controls.
- **Application Delivery:** GitHub Actions CI/CD pipeline builds and pushes app images to ECR, then deploys them to EKS.
- **Observability:** Container Insights and CloudWatch Logs for metrics, dashboards, and alerts.
- **Cost Visibility:** Unified tagging and an AWS Budget for spend awareness.
- **Demo Application:** A simple static frontend served via NGINX and exposed through a LoadBalancer service.


---

## 🚀 Getting Started

### Prerequisites
- AWS account with admin/terraform access
- AWS CLI configured (`aws configure sso` or named profile)
- Terraform (≥ 1.6)
- kubectl
- GitHub repository with Actions enabled

### Setup

1. **Bootstrap Terraform backend**
   - Create an S3 bucket for state and a DynamoDB table for locks.
   - Configure `backend` in `provider.tf` with bucket, key, and table.

2. **Clone this repo**
   ```bash
   git clone https://github.com/<your-org>/aws-eks-app-platform.git
   cd aws-eks-app-platform/infra/terraform
