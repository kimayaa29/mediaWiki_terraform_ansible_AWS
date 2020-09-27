#!/bin/bash
sudo dnf install python3 -y;
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y;
sudo dnf install ansible -y;
sudo dnf install git -y;
git clone https://github.com/kimayaa29/mediaWiki_terraform_ansible_AWS.git /tmp/mediaWiki_terraform_ansible_AWS;
/usr/bin/ansible-playbook /tmp/mediaWiki_terraform_ansible_AWS/main.yml;