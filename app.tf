resource "kubernetes_manifest" "application_argocd___var_chart_" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind"       = "Application"
    "metadata" = {
      "finalizers" = [
        "resources-finalizer.argocd.argoproj.io",
      ]
      "name"      = var.chart
      "namespace" = "argocd"
    }
    "spec" = {
      "destination" = {
        "server"    = "https://kubernetes.default.svc"
        "namespace" = var.namespace
      }
      "project" = "default"
      "source" = {
        "chart" = var.chart
        "helm" = {
          "parameters" = [
            {
              "name"  = var.value_arn
              "value" = module.irsa.iam_role_arn
            },
          ]
          "releaseName" = var.release
          "values"      = var.values
        }
        "repoURL"        = var.repository
        "targetRevision" = var.chart_version
      }
      "syncPolicy" = {
        "automated" = {
          "prune"    = true
          "selfHeal" = true
        }
        "syncOptions" = {
          "CreateNamespace" = true
        }
      }
    }
  }
}
