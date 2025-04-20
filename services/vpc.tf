resource "aws_vpc" "tvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "TVPC"
  }
}


resource "aws_subnet" "tvpc" {
  vpc_id     = aws_vpc.tvpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "TVPC"
  }
}