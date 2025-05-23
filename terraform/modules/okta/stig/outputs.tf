
# Outputs
output "global_session_policy_id" {
  value = okta_policy_signon.global_session_policy.id
}

output "global_session_rule_id" {
  value = okta_policy_rule_signon.global_session_rule.id
}
