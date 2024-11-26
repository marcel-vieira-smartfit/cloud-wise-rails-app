data "aws_caller_identity" "current" {}

module "secrets_manager" {
  source = "terraform-aws-modules/secrets-manager/aws"

  # Secret
  name_prefix             = "database-keys"
  description             = "Database secrets"
  recovery_window_in_days = 30

  # Policy
  create_policy       = true
  block_public_policy = true
  policy_statements = {
    read = {
      sid = "AllowAccountRead"
      principals = [{
        type        = "AWS"
        identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
      }]
      actions   = ["secretsmanager:GetSecretValue"]
      resources = ["*"]
    }
  }

  # Version
  create_random_password           = true
  random_password_length           = 16
  random_password_override_special = "!@#$%^&*()_+"

  tags = {
    Environment = "Development"
  }
}

# Outputs
output "standard_secret_arn" {
  description = "The ARN of the secret"
  value       = module.secrets_manager.secret_arn
}

output "standard_secret_id" {
  description = "The ID of the secret"
  value       = module.secrets_manager.secret_id
}

output "standard_secret_name" {
  description = "The name of the secret"
  value       = module.secrets_manager.secret_name
}

output "standard_secret_replica" {
  description = "Attributes of the replica created"
  value       = module.secrets_manager.secret_replica
}

output "standard_secret_version_id" {
  description = "The unique identifier of the version of the secret"
  value       = module.secrets_manager.secret_version_id
}

output "standard_secret_string" {
  description = "The secret string"
  sensitive   = true
  value       = module.secrets_manager.secret_string
}
