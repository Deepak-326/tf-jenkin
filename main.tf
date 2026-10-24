resource "aws_instance" "vm" {
  ami           = "ami-05d5be6ae9f27c660"
  instance_type = "t3.micro"
  key_name      = "ssh-key"
  tags = {
    Name = "tf-server"
  }
}
