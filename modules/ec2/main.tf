resource "aws_instance" "Demo" {
    ami = "ami-0cb91c7de36eed2cb"
    instance_type = "t2.micro"
}
