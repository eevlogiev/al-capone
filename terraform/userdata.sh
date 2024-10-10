#!/bin/bash
       
#####JENKINS#######
yum update -y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum upgrade -y
sudo dnf install java-11-amazon-corretto -y
yum install jenkins git -y

#######DOCKER############
yum install -y docker
systemctl start docker
systemctl enable docker
usermod -aG docker jenkins
systemctl enable jenkins
systemctl start jenkins
      
######CONFIG########
chown -R jenkins: /var/lib/jenkins/
