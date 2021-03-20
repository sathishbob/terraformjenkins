resource "aws_security_group" "sg" {
  vpc_id      = aws_vpc.vpc.id
  name        = "security-group"
  description = "Allow SSH and http and https"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 } 
