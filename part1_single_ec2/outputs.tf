output "instance_public_ip" {
  description = "Public IP of the single EC2 instance"
  value       = aws_instance.single_instance.public_ip
}

output "instance_public_dns" {
  description = "Public DNS"
  value       = aws_instance.single_instance.public_dns
}
