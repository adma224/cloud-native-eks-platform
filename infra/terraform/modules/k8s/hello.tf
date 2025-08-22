# Simple Apache httpd Deployment
resource "kubernetes_deployment_v1" "apache_hello" {
  metadata {
    name = "apache-hello"
    labels = { app = "apache-hello" }
  }
  spec {
    replicas = 2
    selector { match_labels = { app = "apache-hello" } }
    template {
      metadata { labels = { app = "apache-hello" } }
      spec {
        container {
          name  = "httpd"
          image = "httpd:2.4"
          port { container_port = 80 }
          resources {
            requests = { cpu = "250m", memory = "256Mi" }
            limits   = { cpu = "500m", memory = "512Mi" }
          }
        }
      }
    }
  }
}

# Public LB Service in front of the Deployment
resource "kubernetes_service_v1" "apache_hello_svc" {
  metadata {
    name = "apache-hello-svc"
  }
  spec {
    type     = "LoadBalancer"
    selector = { app = "apache-hello" }
    port {
      port        = 80
      target_port = 80
    }
  }
}

output "hello_world_hostname" {
  description = "Public hostname of the hello-world Service"
  value       = try(kubernetes_service_v1.apache_hello_svc.status[0].load_balancer[0].ingress[0].hostname, "")
}
