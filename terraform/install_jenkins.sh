#!/bin/bash

sudo yum update -y

sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

wget -O jenkins.io.key https://pkg.jenkins.io/redhat-stable/jenkins.io.key

sudo rpm --import jenkins.io.key

sudo yum upgrade

sudo yum install java-11-amazon-corretto-devel -y

sudo yum install jenkins -y --nogpgcheck

sudo systemctl enable jenkins

sudo systemctl start jenkins