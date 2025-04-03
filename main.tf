provider "google" {
  project = "POC-serviciosGCP"
  region  = "us-central1"
}

# Crear 2 Cloud Run seguros
resource "google_cloud_run_service" "cloud_run_services" {
  count = 2
  name  = "cloud-run-${count.index}"
  location = "us-central1"

#Donde la imagen de cada CR, debe tener codigo necesario para funcionar, PEnd
#en este caso, sera una imagen basica
  template {
    spec {
      containers {
#        image = "gcr.io/mi-proyecto/mi-imagen"
        image = "hashicorp/terraform"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

# Crear 2 Cloud Storage Buckets seguros
resource "google_storage_bucket" "buckets" {
  count  = 2
  name   = "mi-bucket-${count.index}-seguro"
  location = "US"
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }

  # Bloquea el acceso público
  uniform_bucket_level_access = true
}
