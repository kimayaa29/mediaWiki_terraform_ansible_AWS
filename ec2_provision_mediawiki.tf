resource "aws_instance" "mediawiki" {
    ami = var.ami
    instance_type = var.instance-type
    user_data = "${data.template_file.user_data.rendered}"
    key_name = var.key_name
    tags = {
        Name = "mediawiki"
    }
}



data "template_file" "user_data" {
    template = "${file("prereq.tpl")}"
}