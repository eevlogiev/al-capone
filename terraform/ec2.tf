resource "aws_instance" "jenkins-ec2" {
  depends_on                  = [aws_ecs_cluster.main]
  ami                         = data.aws_ami.amazon-linux-2023.id
  instance_type               = "t2.medium"
  associate_public_ip_address = true
  user_data                   = file("userdata.sh")
  key_name                    = aws_key_pair.deployer.key_name
  iam_instance_profile        = aws_iam_instance_profile.jenkins_instance_profile.name
  user_data_replace_on_change = true
  vpc_security_group_ids      = [aws_security_group.jenkins.id]
  tags = {
    Name = "jenkins"
  }
}
