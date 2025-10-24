output "flask_public_ip" {
  description = "Flask instance public IP"
  value       = aws_instance.flask_instance.public_ip
}

output "express_public_ip" {
  description = "Express instance public IP"
  value       = aws_instance.express_instance.public_ip
}
