resource "aws_instance" "ec2_monitoreo" {
  ami           = var.ec2_ami_monitoreo
  instance_type = var.ec2_instance_monitoreo
  subnet_id     = aws_subnet.sub_public_monitoreo.id
  key_name      = data.aws_key_pair.rsa_ec2_monitoreo.key_name
  vpc_security_group_ids = [aws_security_group.sg_monitoreo.id]
  user_data = "${file("ec2-script.sh")}"
  tags = {
    Name = "ec2-Monitoreo"
  }
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
    volume_type = "gp3"
    delete_on_termination = true
  }
}

resource "aws_eip" "ec2_eip_ec2_monitoreo" {
  instance = aws_instance.ec2_monitoreo.id
  domain = "vpc"
}
