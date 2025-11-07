# Jumphost Module Outputs

output "instance_id" {
  description = "ID of the jumphost EC2 instance"
  value       = aws_instance.jumphost.id
}

output "instance_arn" {
  description = "ARN of the jumphost EC2 instance"
  value       = aws_instance.jumphost.arn
}

output "public_ip" {
  description = "Public IP address of the jumphost (if associated)"
  value       = aws_instance.jumphost.public_ip
}

output "private_ip" {
  description = "Private IP address of the jumphost"
  value       = aws_instance.jumphost.private_ip
}

output "public_dns" {
  description = "Public DNS name of the jumphost (if associated)"
  value       = aws_instance.jumphost.public_dns
}

output "private_dns" {
  description = "Private DNS name of the jumphost"
  value       = aws_instance.jumphost.private_dns
}

output "security_group_id" {
  description = "ID of the security group created for the jumphost (if created)"
  value       = var.create_security_group ? aws_security_group.jumphost[0].id : null
}

output "security_group_arn" {
  description = "ARN of the security group created for the jumphost (if created)"
  value       = var.create_security_group ? aws_security_group.jumphost[0].arn : null
}

output "key_name" {
  description = "Name of the SSH key pair used by the jumphost"
  value       = aws_instance.jumphost.key_name
}

output "availability_zone" {
  description = "Availability zone where the jumphost is deployed"
  value       = aws_instance.jumphost.availability_zone
}
