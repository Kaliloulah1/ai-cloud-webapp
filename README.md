# 🌐 AI Cloud Web App — CI/CD with GCP Cloud Run

![GCP](https://img.shields.io/badge/GCP-Cloud_Run-4285F4?logo=google-cloud)
![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC?logo=terraform)
![Docker](https://img.shields.io/badge/Container-Docker-2496ED?logo=docker)
![CI/CD](https://img.shields.io/badge/CI/CD-Cloud_Build-orange?logo=google-cloud)
![Status](https://img.shields.io/badge/Status-Live-brightgreen)

A production-ready CI/CD pipeline that automatically builds, pushes, and deploys a containerized web application to **Google Cloud Run** using **Cloud Build**, **Artifact Registry**, and **Terraform**.

🌐 **Live Demo:** [https://ibrahimcamara.pro](https://ibrahimcamara.pro)

---

## 📐 Architecture Overview

```
Developer
    │
    │ git push (main branch)
    ▼
GitHub Repository
    │
    │ triggers
    ▼
Cloud Build Trigger
    │
    ▼
Cloud Build (cloudbuild.yaml)
    │
    ├── Build Docker image
    ├── Push to Artifact Registry
    └── Deploy to Cloud Run
                │
                ▼
        Cloud Run Service
         (ai-cloud-webapp)
                │
                │ HTTPS traffic
                ▼
           End Users
```

---

## ☁️ GCP Services Used

| Service | Purpose |
|---|---|
| **Cloud Run** | Serverless container hosting — scales to zero |
| **Cloud Build** | CI/CD pipeline — builds and deploys on every push |
| **Artifact Registry** | Docker image storage |
| **IAM** | Service accounts and least-privilege roles |
| **Terraform** | Infrastructure as Code for all GCP resources |
| **GitHub** | Source control + Cloud Build trigger |

---

## 🔧 Tech Stack

- **Cloud:** GCP (Cloud Run, Cloud Build, Artifact Registry)
- **IaC:** Terraform 1.x
- **Container:** Docker (python:3.9-slim)
- **App:** Python HTTP server serving static HTML
- **CI/CD:** Google Cloud Build (cloudbuild.yaml)
- **Auth:** IAM Service Accounts
- **Domain:** Custom domain with HTTPS via Cloud Run

---

## 📁 Repository Structure

```
ai-cloud-webapp/
├── Dockerfile           # Python 3.9-slim, serves index.html on port 8080
├── index.html           # Web application
├── cloudbuild.yaml      # CI/CD pipeline — build, push, deploy
└── terraform/           # GCP infrastructure as code
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

---

## 🚀 CI/CD Pipeline Flow

Every `git push` to the `main` branch triggers this automated pipeline:

```
1. Developer pushes code to GitHub (main branch)
2. Cloud Build Trigger detects the commit
3. Cloud Build executes cloudbuild.yaml:
   a. Builds Docker image
   b. Pushes image to Artifact Registry
   c. Deploys image to Cloud Run
4. Cloud Run serves traffic securely over HTTPS
5. Custom domain ibrahimcamara.pro routes to Cloud Run
```

---

## 🏗️ Infrastructure Deployment

### Prerequisites
- GCP account with billing enabled
- `gcloud` CLI installed and authenticated
- Terraform >= 1.0 installed

### Step 1: Clone the repository
```bash
git clone https://github.com/Kaliloulah1/ai-cloud-webapp.git
cd ai-cloud-webapp
```

### Step 2: Deploy infrastructure with Terraform
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Step 3: Trigger deployment
```bash
git add .
git commit -m "Deploy update"
git push origin main
```
Cloud Build automatically picks up the push and deploys! ✅

### Step 4: Verify deployment
```bash
gcloud run services list --region us-central1
```

---

## 🔒 Security Design

- Cloud Run service account has **minimum required permissions** only
- Docker images stored in **private Artifact Registry**
- All traffic served over **HTTPS** (managed by Cloud Run)
- No secrets stored in code — IAM roles used for authentication

---

## 🌐 Multi-Cloud Context

This project is part of a broader **multi-cloud portfolio**:

| Cloud | Stack | Repo |
|---|---|---|
| GCP | Cloud Run + Cloud Build + Artifact Registry + Terraform | This repo |
| AWS | ECS Fargate + ECR + ALB + Terraform | [aws-ecs-infrastructure-terraform](https://github.com/Kaliloulah1/aws-ecs-infrastructure-terraform) |

---

## 👨‍💻 Author

**Ibrahim Camara** — AWS Cloud & DevOps Engineer

🌐 [ibrahimcamara.pro](https://ibrahimcamara.pro)
💼 [LinkedIn](https://linkedin.com/in/ibrahim-camara-devops)
📂 [GitHub](https://github.com/Kaliloulah1)
📝 [Blog](https://medium.com/@ibrahimcamara1)
