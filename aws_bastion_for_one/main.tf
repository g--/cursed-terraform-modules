resource "aws_instance" "landing_pad" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.this.id]
  key_name               = var.key_name

  tags = {
    Name = "${module.whoami.username} personal bastion"
  }
}

resource "aws_security_group" "this" {
  name        = "sshFrom${local.tf_runners_name}Home"
  description = "ssh from the place ${module.whoami.username} last ran terraform on their ${module.whoami.hostname}. For testing purposes. I hope."
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${module.whoami.ip}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow sshing from ${module.whoami.username} home"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

locals {
  default_username = "ubuntu"
}

module "whoami" {
  source = "../whats_my_ip"
}

locals {
  tf_runners_name = title(replace(module.whoami.username, ".", ""))
}

