resource "aws_instance" "centos" {
  ami                    = "${var.centos}"
  instance_type          = "${var.centos_instance_type}"
  key_name               = "${var.key}"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.public_subnet.id

  #provisioner "file" {
  #    source      = "nginx.conf"
  #    destination = "/home/ec2-user/"
  #  }

  associate_public_ip_address = true
  tags = {
    Name = "centos_instance"
  }

  user_data = <<HEREDOC
#!/bin/bash
yum install git -y
HEREDOC
}
