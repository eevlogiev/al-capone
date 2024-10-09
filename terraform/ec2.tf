resource "aws_instance" "ec2" {
  depends_on                  = [aws_ecs_cluster.main]
  ami                         = data.aws_ami.amazon-linux-2023.id
  instance_type               = "t2.medium"
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")
  key_name                    = aws_key_pair.deployer.key_name
  iam_instance_profile        = aws_iam_instance_profile.profile.name
  user_data_replace_on_change = true
  vpc_security_group_ids      = [aws_security_group.jenkins.id]
  #  network_interface { # put EC2 instance in default VPC
  #    network_interface_id = aws_network_interface.interface.id
  #    device_index         = 0
  #  }
  tags = {
    Name = "jenkins"
  }
}