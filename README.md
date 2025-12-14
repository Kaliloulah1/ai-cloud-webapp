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
