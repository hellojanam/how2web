resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "Allows SSH to Bastion from everywhere"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allows SSH from everywhere"
  }

  ingress {
    from_port   = 1194
    to_port     = 1194
    protocol    = "UDP"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allows OpenVPN from everywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-bastion"
  }
}

output "bastion_secgroup" {
  value = aws_security_group.bastion.id
}