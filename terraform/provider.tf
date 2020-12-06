provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "example" {
  ami           = "ami-09558250a3419e7d0"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform"
  }
}