resource "aws_vpc" "vpc18" {
  cidr_block = var.vpccidr
  tags = {
    Name = "vpc18"
  }
}


resource "aws_internet_gateway" "igw18" {
  tags = {
     Name = "igw18"
  }
  vpc_id = aws_vpc.vpc18.id
}


data "aws_availabilty_zone" "az" {}

resource "aws_subnet" "sn1" {
  vpc_id = aws_vpc.vpc18.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.1.0/24"
  availability_zone = data.aws_availabilty_zone.az[0]
  tags = {
    Name = "sn1"
  }
}


resource "aws_subnet" "sn2" {
  vpc_id = aws_vpc.vpc18.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.4.0/24"
  availability_zone = data.aws_availabilty_zone.az[1]
  tags = {
    Name = "sn1"
  }

}

resource "aws_route_table" "rt" {

    vpc_id = aws_vpc.vpc18
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw18.id
    }
  
}


resource "aws_route_table_association" "rta" {

    subnet_id = aws_subnet.sn1.id
    route_table_id = aws_route_table.rt.id
  
}

resource "aws_route_table_association" "rta2" {

    subnet_id = aws_subnet.sn2.id
    route_table_id = aws_route_table.rt.id
  
}


