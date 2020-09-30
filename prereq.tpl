#!/bin/bash
sudo dnf install python3 -y;
sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y;
sudo dnf install ansible -y;
sudo dnf install git -y;
sleep 100
git clone https://github.com/kimayaa29/mediaWiki_terraform_ansible_AWS.git /tmp/mediaWiki_terraform_ansible_AWS;
sleep 60
/usr/bin/ansible-playbook /tmp/mediaWiki_terraform_ansible_AWS/media_wiki_ansible/main.yml -vvv > /tmp/ansible.log
