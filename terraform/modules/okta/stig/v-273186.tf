# Global session policy (equivalent to Security >> Global Session Policy)
resource "okta_policy_signon" "global_session_policy" {
  name        = "Global Session Policy"
  description = "Global session policy with 15-minute idle timeout"
  type        = "OKTA_SIGN_ON"
  priority    = 1
  status      = "ACTIVE"
}

# Global session policy rule (equivalent to "Add rule" with 15-minute idle time)
resource "okta_policy_rule_signon" "global_session_rule" {
  policy_id = okta_policy_signon.global_session_policy.id
  name      = "15-Minute Global Session Idle Timeout"
  priority  = 1
  status    = "ACTIVE"

  # This is the key setting: "Maximum Okta global session idle time" = 15 minutes
  session_idle     = 15  # Minutes of inactivity before logout
  session_lifetime = var.max_session_lifetime  # Maximum session duration
  
  access = "ALLOW"
  network_connection = "ANYWHERE"
}

# Optional: Application sign-on policy for specific apps
resource "okta_app_signon_policy" "app_session_policy" {
  count       = length(var.applications)
  description = "15-minute session timeout for ${var.applications[count.index]}"
  
  # Reference to the application
  # You'll need to data source or create the apps separately
}

# Data source to get existing groups (if targeting specific groups)
data "okta_groups" "target_groups" {
  count = length(var.target_group_names)
  q     = var.target_group_names[count.index]
}
