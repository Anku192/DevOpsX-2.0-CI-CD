terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
    }
  }

  required_version = ">= 1.5.0"
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_namespace" "devopsx2" {
  metadata {
    name = "devopsx2"
  }
}

resource "kubernetes_deployment" "app" {
  metadata {
    name      = "devopsx2-app"
    namespace = kubernetes_namespace.devopsx2.metadata[0].name

    labels = {
      app = "devopsx2-app"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "devopsx2-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "devopsx2-app"
        }
      }

      spec {
        container {
          name              = "devopsx2-container"
          image             = "ankurpb/devopsx2-app:1.0"
          image_pull_policy = "Always"

          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "app" {
  metadata {
    name      = "devopsx2-service"
    namespace = kubernetes_namespace.devopsx2.metadata[0].name
  }

  spec {
    selector = {
      app = "devopsx2-app"
    }

    type = "NodePort"

    port {
      port        = 5000
      target_port = 5000
      node_port   = 30080
    }
  }
}