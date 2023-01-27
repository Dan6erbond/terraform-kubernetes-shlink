terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.13.1"
    }
  }
}

locals {
  match_labels = merge({
    "app.kubernetes.io/name"     = "shlink"
    "app.kubernetes.io/instance" = "shlink"
  }, var.match_labels)
  labels = merge(local.match_labels, var.labels)
}

resource "kubernetes_deployment" "shlink" {
  metadata {
    name      = "shlink"
    namespace = var.namespace
    labels    = local.labels
  }
  spec {
    replicas = 1
    selector {
      match_labels = local.labels
    }
    template {
      metadata {
        labels = local.labels
        annotations = {
          "ravianand.me/config-hash" = sha1(jsonencode(merge(
            kubernetes_config_map.shlink.data,
            kubernetes_secret.shlink.data
          )))
        }
      }
      spec {
        container {
          image = var.image_registry == "" ? "${var.image_repository}:${var.image_tag}" : "${var.image_registry}/${var.image_repository}:${var.image_tag}"
          name  = var.container_name
          args  = ["-config", "/config.yaml"]
          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.shlink.metadata.0.name
                key  = "db-password"
              }
            }
          }
          env_from {
            config_map_ref {
              name = kubernetes_config_map.shlink.metadata.0.name
            }
          }
          port {
            name           = "http"
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "shlink" {
  metadata {
    name      = var.service_name
    namespace = var.namespace
    labels    = local.labels
  }
  spec {
    type     = var.service_type
    selector = local.match_labels
    port {
      name        = "http"
      port        = 8080
      target_port = "http"
    }
  }
}

resource "kubernetes_secret" "shlink" {
  metadata {
    name      = "shlink"
    namespace = var.namespace
  }
  data = {
    "db-password" = var.db_password
  }
}

resource "kubernetes_config_map" "shlink" {
  metadata {
    name      = "shlink"
    namespace = var.namespace
  }
  data = {
    "DEFAULT_DOMAIN"      = var.host
    "IS_HTTPS_ENABLED"    = var.https
    "GEOLITE_LICENSE_KEY" = var.geolite_license_key
    "INITIAL_API_KEY"     = var.initial_api_key
    "DB_DRIVER"           = var.db_driver
    "DB_NAME"             = var.db_name
    "DB_USER"             = var.db_user
    "DB_HOST"             = var.db_host
    "DB_PORT"             = var.db_port
    "REDIS_SERVERS"       = var.redis_servers
  }
}
