resource "aws_ecr_repository" "flask" {
  name                 = "flask-backend-repo"
  image_tag_mutability = "MUTABLE"

  # Prevent Terraform from trying to recreate or delete existing repos
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [name]
  }
}

resource "aws_ecr_repository" "express" {
  name                 = "express-frontend-repo"
  image_tag_mutability = "MUTABLE"

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [name]
  }
}

# Outputs
output "flask_ecr_repo_url" {
  value = aws_ecr_repository.flask.repository_url
}

output "express_ecr_repo_url" {
  value = aws_ecr_repository.express.repository_url
}
