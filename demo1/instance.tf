resource "aws_instance" "webapp" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t1.micro"
  count = "${var.app_servers_count}"
  # ensure servers are launched in seperate AZs
  availability_zone = "${ element(split(",", module.aws_az.list_all), count.index) }" 
  tags {
       Name = "WebApp"
    }

  # the VPC subnet
  subnet_id = "${aws_subnet.main-public-1.id}"

  # the security group
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]

  # the public SSH key
  key_name = "${aws_key_pair.mykeypair.key_name}"

   #increase storage of root volume
  root_block_device{
    volume_size = 16
    volume_type = "gp2"
    delete_on_termination = true
  }
}

resource "aws_instance" "database" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t1.micro"
  associate_public_ip_address = "false"
  count = "${var.db_servers_count}"
  # ensure servers are launched in seperate AZs
  availability_zone = "${ element(split(",", module.aws_az.list_all), count.index) }" 
  vpc_security_group_ids = ["${aws_security_group.MySQLDB.id}"]
  # the VPC subnet
  subnet_id = "${aws_subnet.main-private-1.id}"

 
  tags {
        Name = "sql database"
  }
}


