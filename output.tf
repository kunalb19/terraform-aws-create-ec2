output "instance_id" {
  value = aws_instance.aws_instance.id
}
output "instance_public_ip" {
  value = aws_instance.aws_instance.public_ip
}
output "instance_private_ip" {
  value = aws_instance.aws_instance.private_ip
}
output "availability_zone" {
  value = aws_instance.aws_instance.availability_zone
}