#!/bin/bash

firewall-cmd --permanent --zone=public --add-service=http
systemctl restart firewalld
