resource "aws_key_pair" "bastion_keypair" {
  key_name   = "${var.project_name}-bastion-key"
  public_key = var.public_key
}

resource "aws_iam_instance_profile" "bastion_profile" {
  name = "${var.project_name}-bastion-profile"
  role = aws_iam_role.bastion_role.name
}

resource "aws_instance" "bastion" {
  ami                     = "ami-0245697ee3e07e755" # Debian 10 from https://wiki.debian.org/Cloud/AmazonEC2Image/Buster
  instance_type           = var.bastion_instance_type
  key_name                = aws_key_pair.bastion_keypair.id
  vpc_security_group_ids  = [aws_security_group.bastion.id]
  subnet_id               = var.bastion_subnet
  iam_instance_profile    = aws_iam_instance_profile.bastion_profile.id
  associate_public_ip_address = true

  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }

  tags = {
    Name = "${var.project_name}-bastion"
  }

  user_data = templatefile("${path.module}/bastion_bootstrap.sh",
    {
      helmfile_version  = var.helmfile_version,
      kubectl_version   = var.kubectl_version
    })
}