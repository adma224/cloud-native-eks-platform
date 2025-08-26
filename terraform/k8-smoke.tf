resource "kubernetes_namespace" "obs_system" {
  metadata {
    name = "obs-system"
    labels = {
        project = var.project
        env = var.env
    }
  }
  depends_on = [ module.k8 ]
}