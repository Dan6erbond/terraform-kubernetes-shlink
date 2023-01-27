output "service_name" {
  description = "Service name for shlink deployment"
  value       = kubernetes_service.shlink.metadata.0.name
}

output "service_port" {
  description = "Port exposed by the service"
  value       = kubernetes_service.shlink.spec.0.port.0.name
}
