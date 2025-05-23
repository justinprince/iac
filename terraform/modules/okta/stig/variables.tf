
# Variables
variable "okta_org_name" {
  type        = string
  description = "Okta organization name"
}

variable "okta_base_url" {
  type        = string
  description = "Okta base URL (e.g., oktapreview.com, okta.com)"
  default     = "okta.com"
}

variable "okta_api_token" {
  type        = string
  description = "Okta API token"
  sensitive   = true
}

variable "target_groups" {
  type        = list(string)
  description = "List of group IDs to apply the policy to"
  default     = []  # Empty means apply to everyone
}

variable "target_group_names" {
  type        = list(string)
  description = "List of group names to lookup and apply policy to"
  default     = []
}

variable "max_session_lifetime" {
  type        = number
  description = "Maximum session lifetime in minutes"
  default     = 480  # 8 hours
}

variable "applications" {
  type        = list(string)
  description = "List of application names to apply specific policies"
  default     = []
}
