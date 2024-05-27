
resource "aws_vpc" "my_vpc" {
  cidr_block = "192.168.40.0/24"
  tags = {
    Name = "vpc-ceb04-${var.vpc-ceb04}"
    Created_by = var.ceb04
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "192.168.40.0/28"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet01-ceb04-${var.pub-subnet01}"
    public_subnet = var.pub-subnet01 
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "192.168.40.16/28"
  tags = {
    Name = "private-subnet01-ceb04-${var.priv-subnet01}"
    private_subnet = var.priv-subnet01
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "igw-ceb04-${var.igw-ceb04}"
    internet_gateway = var.igw-ceb04
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.id
  depends_on    = [aws_internet_gateway.gw]
  tags = {
    Name = "nat-gw-ceb04"
    nat_gateway = var.nat-gw-ceb04
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "pub-rt-ceb04"
    pub_route_table = var.pub-rt-ceb04
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "priv-rt-ceb04"
    priv_route_table = var.priv-rt-ceb04
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web_traffic"
  description = "Allow Web inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description      = "SSH from Anywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "HTTP from Anywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_web"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0044a0897b53acfb6" # This is an Amazon Linux 2 AMI in us-east-1. Update it based on your region and desired AMI
  instance_type = "t3.nano"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_web.id]
  key_name = aws_key_pair.deployer.key_name
  tags = {
    Name = "MyWebServer"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = var.ssh_key

}