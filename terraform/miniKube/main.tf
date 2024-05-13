provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "my-nginx-deployment"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "nginx"

          port {
            container_port = 4001
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nginx" {
  metadata {
    name = "my-nginx-service"
  }

  spec {
    selector = {
      app = "nginx"
    }

    port {
      name        = "http"
      protocol    = "TCP"
      port        = 4001
      target_port = 4001
    }
  }
}
