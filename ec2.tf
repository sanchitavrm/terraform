provider "aws" {
  region     = "us-east-2"
  access_key = "first"
  secret_key = "second"
}

AKIAQ4NXP3NYTUIWXCW6

9JwyBUBRJNEK5SbGFxy724NovWKYENODYds5FYx1

resource "aws_instance" "Jenkins" {
    ami = "ami-0cb91c7de36eed2cb"
    instance_type = "t2.micro"
}
