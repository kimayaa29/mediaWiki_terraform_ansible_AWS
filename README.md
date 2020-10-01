# mediaWiki_terraform_ansible_AWS

Below assumptions are made
  You have AWS CLI already configured to execute this code using terraform.
  
1. This code uses Elastic load balancers along with auto scaling feature to balance the traffic to the mediawiki web server.
2. Instances span accross two public subnets and allow http traffic only through the ELB to maintain the security.
3. VPC, route tables, internet gateway, security groups are created separately for this infrastructure.
4. Code deployment is achieved using Ansible playbooks which are copied over to the server through GitHub.
5. User data feature is used to install the neccesary packages for ansible to execute.
6. After executing Terraform apply command, the output will consists of a end point name to access the mediawiki application from the browser.
7. Kindly wait for around 15 mins to hit the URL, as ansible playbook is being executed in the background takes some time.


