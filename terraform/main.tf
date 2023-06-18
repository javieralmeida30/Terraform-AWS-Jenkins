provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

data "aws_availability_zones" "available"{}

resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "Default subnet for us-east-2a"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow 8080 & 22 inbound traffic"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description      = "ssh access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
  ingress {
    description      = "http access"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
resource "aws_instance" "jenkins_server" {
  ami                    = "ami-0e820afa569e84cc1"
  instance_type          = "t2.micro"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [ aws_security_group.allow_tls.id ]
  key_name               = "key.pem"
  tags = {
    Name = "Jenkins_server"
  }

}


resource "null_resource" "name" {




  connection {

    type = "ssh"
    user = "ec2-user"
    private_key = file("~/Downloads/key.pem")
    host = aws_instance.jenkins_server.public_ip
  }

  provisioner "file"{
    source = "install_jenkins.sh"
    destination = "/tmp/install_jenkins.sh"
  }

  provisioner "remote-exec" {
    inline = [
        "sudo chmod +x /tmp/install_jenkins.sh",
        "sh /tmp/install_jenkins.sh"
    ]
  }
  depends_on = [
    aws_instance.jenkins_server
  ]
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  skip_final_snapshot  = true
}

resource "aws_s3_bucket" "example" {
  bucket = "terraformjavieralmeida"

  tags = {
    Name        = "terraformjavieralmeida"
    Environment = "Test"
  }
}
