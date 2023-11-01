################################################################################
# Yandex IDs
variable "yandex_cloud_id" {
  default = "b1gnjst4dee7j34hrh7s"
}

variable "yandex_folder_id" {
  default = "b1gd02p4ii36h57v2h14"
}

variable "yandex_compute_default_zone" {
  default = "ru-central1-a"
}

################################################################################
# DockerHub
variable "dockerhub_login" {
  default = "awertoss"
}

variable "dockerhub_password" {
  default   = "v"
  sensitive = true
}

################################################################################
# GitHub
variable "github_personal_access_token" {
  default   = "ghp_t3X****"
  sensitive = true
}

variable "github_webhook_secret" {
  default = "diplomasecret"
}

variable "github_login" {
  default = "awertoss"
}