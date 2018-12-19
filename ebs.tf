resource "aws_ebs_volume" "ebs-volume-1" {
    availability_zone = "${var.AWS_AVAILABILITY_ZONE}"
    size = 5
    type = "gp2" 
    tags {
        Name = "extra volume data"
    }
}

resource "aws_volume_attachment" "ebs-volume-1-attachment" {
  device_name = "/dev/xvdh"
  volume_id = "${aws_ebs_volume.ebs-volume-1.id}"
  instance_id = "${aws_instance.database.id}"
}   