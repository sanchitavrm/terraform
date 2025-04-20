resource "aws_instance" "Demo" {
    ami = var.ami
    instance_type = var.instance_type
    tags = {
        Name = "Demo"
    }
}
