resource "aws_instance" "ubuntu_instance" {
  ami                         = "${var.ubuntu}"
  instance_type               = "${var.ubuntu_instance_type}"
  key_name                    = "${var.key}"
  monitoring                  = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "ubuntu_instance"
  }

  # network_interface {
  #    network_interface_id = "${aws_network_interface.web.id}"
  #    device_index         = 0
  #  }

  user_data = <<HEREDOC
#!/bin/bash
apt -get install git -y
HEREDOC
}

