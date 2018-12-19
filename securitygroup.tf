resource "aws_security_group" "allow-ssh" {
  vpc_id = "${aws_vpc.main.id}"
  name = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    } 
tags {
    Name = "allow-ssh"
  }
}
resource "aws_security_group" "MySQLDB" {
    name = "MySQLDB"
     tags {
         Name = "MySQLDB"
    }
    description = "ONLY tcp CONNECTION INBOUND"
     vpc_id = "${aws_vpc.main.id}"
     ingress {
         from_port = 3306
         to_port = 3306
         protocol = "TCP"
         security_groups = ["${aws_security_group.allow-ssh.id}"]
    }
    ingress {
        from_port = "22"
        to_port = "22"
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
