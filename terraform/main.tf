data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "main" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  key_name = "Jenkins Server"
  tags = {
    Name = "JenkinsMain"
  }
}
resource "aws_eip" "ip" {

  instance = "${aws_instance.main.id}"

}
resource "aws_instance" "node" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  key_name = "Jenkins Server"
  tags = {
    Name = "JenkinsNode"
  }
}
resource "aws_eip" "node" {

  instance = "${aws_instance.node.id}"

}

