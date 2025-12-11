############################################
# Terraform + Provider Configuration
############################################

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "google" {
  project = "alert-archive-480606-c9"   # <-- Replace with your project ID if needed
  region  = "us-central1"
}

############################################
# Artifact Registry Repository
############################################

resource "google_artifact_registry_repository" "docker_repo" {
  location       = "us-central1"
  repository_id  = "webapp-repo"
  description    = "Docker repository for AI Cloud Bootcamp web application"
  format         = "DOCKER"
}

############################################
# Cloud Run Service Account
############################################

resource "google_service_account" "cloudrun_sa" {
  account_id   = "cloudrun-exec-sa"
  display_name = "Cloud Run Execution Service Account"
}

############################################
# IAM Bindings (Fixed)
############################################

resource "google_project_iam_binding" "run_admin" {
  project = "alert-archive-480606-c9"   # <-- REQUIRED FIELD ADDED
  role    = "roles/run.admin"

  members = [
    "serviceAccount:${google_service_account.cloudrun_sa.email}"
  ]
}

resource "google_project_iam_binding" "artifact_reader" {
  project = "alert-archive-480606-c9"   # <-- REQUIRED FIELD ADDED
  role    = "roles/artifactregistry.reader"

  members = [
    "serviceAccount:${google_service_account.cloudrun_sa.email}"
  ]
}

############################################
# Cloud Run Deployment
############################################

resource "google_cloud_run_service" "cloudrun_app" {
  name     = "ai-cloud-webapp"
  location = "us-central1"

  template {
    spec {
      service_account_name = google_service_account.cloudrun_sa.email

      containers {
        # Image uploaded manually or later through CI/CD
        image = "us-central1-docker.pkg.dev/alert-archive-480606-c9/webapp-repo/html-demo-app:v1"

        ports {
          container_port = 8080
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

############################################
# Allow Public Access to Cloud Run
############################################

resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_service.cloudrun_app.name
  location = google_cloud_run_service.cloudrun_app.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

############################################
# Output Cloud Run URL
############################################

output "cloud_run_url" {
  value = google_cloud_run_service.cloudrun_app.status[0].url
}
