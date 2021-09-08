provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "ssh_traffic" {
  name        = "ssh_traffic"
  description = "Allow SSH inbound traffic"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_commit           = "893c1ebc03c874367595a6cf318670312ea6673b"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-09-08 16:42:43"
    git_last_modified_by = "triti@users.noreply.github.com"
    git_modifiers        = "triti"
    git_org              = "triti"
    git_repo             = "terragoat"
    yor_trace            = "7cf8d0f8-97be-48f5-8d9c-775e91fd3943"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "526687ead035b6b38fe84675980400ef7ae5fda7"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-09-08 16:44:16"
    git_last_modified_by = "triti@users.noreply.github.com"
    git_modifiers        = "triti"
    git_org              = "triti"
    git_repo             = "terragoat"
    yor_trace            = "ea5014f1-18cd-4ac6-ac5e-a4cf56210a36"
  }
  ebs_optimized = true
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
