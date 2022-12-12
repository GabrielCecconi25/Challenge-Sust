variable "az-1a" {
  type        = string
  default     = "us-east-1a"
  description = "Availability zone for us-east-1a"
}

variable "az-1b" {
  type        = string
  default     = "us-east-1b"
  description = "Availability zone for us-east-1b"
}

variable "nginx_domain" {
  type        = string
  default     = "www.nginx.gabrieltorres.ga"
  description = "static domain name"
}

variable "www_domain" {
  type        = string
  default     = "www.gabrieltorres.ga"
  description = "www domain name"
}

variable "root_domain" {
  type        = string
  default     = "gabrieltorres.ga"
  description = "root domain name"
}
