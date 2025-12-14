#  Google Cloud Run CI/CD Demo:

This project is a hands-on DevOps showcase that deploys a simple Python HTTP server
(serving an `index.html` page) to **Google Cloud Run** using a fully automated
**CI/CD pipeline** with **Cloud Build** and **Artifact Registry**.

## Architecture:

- **Source Control**: GitHub repository `ai-cloud-webapp`
- **CI/CD Engine**: Google Cloud Build with a GitHub-trigger (`deploy-on-commit`)
- **Container Registry**: Artifact Registry repository `webapp-repo` in `us-central1`
- **Runtime**: Cloud Run service `ai-cloud-webapp` (serverless, HTTPS, auto-scaling)
- **Security**:
  - Custom service accounts for Cloud Build and Cloud Run
  - Least-privilege IAM roles (Run Admin, Artifact Registry Writer, Logging Writer)
- **Logging**:
  - Build logs and runtime logs sent to **Cloud Logging** (`CLOUD_LOGGING_ONLY`)

### High-Level Flow:

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
