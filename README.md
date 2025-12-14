## AI Cloud Web App – CI/CD with Google Cloud Run:
# Project Overview:

- This project demonstrates a production-ready CI/CD pipeline that automatically builds, pushes, and deploys a containerized web application to Google Cloud Run using Google Cloud Build and GitHub.

## The goal of this project is to showcase:

- Cloud-native CI/CD design

- Secure IAM configuration

- Artifact Registry usage

- Serverless deployment with Cloud Run

- Real-world DevOps troubleshooting and recovery

## Live Demo (Production):
- The application is live and publicly accessible on Google Cloud Run:
- Public HTTPS Endpoint:
https://ai-cloud-webapp-412058831292.us-central1.run.app
- Cloud Run automatically, scales the application and only runs when traffic is received.

---

##  Architecture Overview

# Workflow:

1- Developer pushes code to GitHub (main branch)

2- Cloud Build Trigger detects the commit

3- Cloud Build:

- Builds Docker image

- Pushes image to Artifact Registry

- Deploys the image to Cloud Run

4- Cloud Run serves traffic securely over HTTPS

Key Services Used:

- Google Cloud Run

- Google Cloud Build

- Artifact Registry

- GitHub (Source Control)

- Docker

- IAM (Service Accounts & Roles)

## Tech Stack:

- Language: HTML (static web app)

- Container: Docker (python:3.9-slim)

- CI/CD: Google Cloud Build (Triggers)

- Registry: Artifact Registry

- Compute: Google Cloud Run (Fully Managed)

- Authentication: IAM Service Accounts

- Tools: Google Cloud Shell, GitHub

## High-Level Flow:

- Developer → GitHub → Cloud Build Trigger → Cloud Build → Artifact Registry → Cloud Run → End Users

             
             
             +---------------------+
             |     GitHub Repo     |
             |  ai-cloud-webapp    |
             +----------+----------+
                        |
                        | Push (git commit)
                        v
             +---------------------+
             |  Cloud Build Trigger|
             |  (deploy-on-commit) |
             +----------+----------+
                        |
                        v
             +---------------------+
             |     Cloud Build     |
             |  cloudbuild.yaml    |
             +----------+----------+
          build / push  |
                        v
       +----------------+--------------------+
       |          Artifact Registry          |
       |  us-central1 / webapp-repo          |
       +----------------+--------------------+
                        |
                        | container image
                        v
             +-----------------------------+
             |          Cloud Run          |
             |  Service: ai-cloud-webapp   |
             |  Region: us-central1        |
             +-----------------------------+
                        |
                        | HTTPS traffic
                        v
                 End Users / Browser


##  Repository Structure:

.
├── Dockerfile        # Python 3.9-slim, serves index.html on port 8080 ( Container definition )
├── index.html        # Web application
└── cloudbuild.yaml   # Build, push and deploy CI/CD pipeline definition


