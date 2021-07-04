## key pair created

resource "aws_key_pair" "key" {

  key_name      = "${var.project}-keypair"
  public_key    = file("rahul.pub")
## need to create a sshkeypair using ssh-keygen with name different name and reblace above line

  tags = {
    Name = "${var.project}-keypair"
  }
    
}

## Intance for webserver 

resource "aws_instance" "web" {
  ami                           = var.insta.ami
  instance_type                 = var.insta.type
  associate_public_ip_address   = true
  key_name                      = aws_key_pair.key.key_name
  vpc_security_group_ids        = [  aws_security_group.web.id ]
  subnet_id                     = aws_subnet.public1.id  

  tags = {
    Name = "${var.project}-webserver"
  }
}

## Intance for SSH

resource "aws_instance" "ssh" {
  ami                           = var.insta.ami
  instance_type                 = var.insta.type
  associate_public_ip_address   = true
  key_name                      = aws_key_pair.key.key_name
  vpc_security_group_ids        = [  aws_security_group.ssh.id ]
  subnet_id                     = aws_subnet.public2.id  

  tags = {
    Name = "${var.project}-bastion"
  }
}

## Intance for DB server

resource "aws_instance" "ssh" {
  ami                           = var.insta.ami
  instance_type                 = var.insta.type
  key_name                      = aws_key_pair.key.key_name
  vpc_security_group_ids        = [  aws_security_group.db.id ]
  subnet_id                     = aws_subnet.private1.id  

  tags = {
    Name = "${var.project}-database"
  }
}