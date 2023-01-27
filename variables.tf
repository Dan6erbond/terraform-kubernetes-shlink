variable "namespace" {
  description = "Namespace where shlink is deployed"
  type        = string
  default     = "default"
}

variable "image_registry" {
  description = "Image registry, e.g. gcr.io, docker.io"
  type        = string
  default     = ""
}

variable "image_repository" {
  description = "Image to start for this pod"
  type        = string
  default     = "shlinkio/shlink"
}

variable "image_tag" {
  description = "Image tag to use"
  type        = string
  default     = "stable"
}

variable "container_name" {
  description = "Name of the shlink container"
  type        = string
  default     = "shlink"
}

variable "match_labels" {
  description = "Match labels to add to the shlink deployment, will be merged with labels"
  type        = map(any)
  default     = {}
}

variable "labels" {
  description = "Labels to add to the shlink deployment"
  type        = map(any)
  default     = {}
}

variable "host" {
  description = "Public facing hostname for shlink"
  type        = string
  default     = "localhost:8080"
}

variable "https" {
  description = "Whether HTTPS is enabled for shlink"
  type        = bool
  default     = true
}

variable "geolite_license_key" {
  description = "Geolite2 license key for visit tracking"
  type        = string
  default     = ""
}

variable "initial_api_key" {
  description = "Initial API key for admin user"
  type        = string
  default     = ""
}

variable "service_name" {
  description = "Name of service to deploy"
  type        = string
  default     = "shlink"
}

variable "service_type" {
  description = "Type of service to deploy"
  type        = string
  default     = "ClusterIP"
}

variable "db_driver" {
  description = "DB driver to use"
  type        = string
  default     = "sqlite"
}

variable "db_host" {
  description = "DB hostname"
  type        = string
  default     = ""
}

variable "db_user" {
  description = "User for database"
  type        = string
  default     = ""
}

variable "db_password" {
  description = "Password for database"
  type        = string
  default     = ""
}

variable "db_port" {
  description = "Port for DB"
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "Database to use"
  type        = string
  default     = ""
}

variable "redis_servers" {
  description = "Comma-separated list of Redis servers to use, including credentials"
  type        = string
  default     = ""

}
