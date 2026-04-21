resource "aws_vpc" "codeserver_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "codeserver-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.codeserver_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "codeserver-public-${count.index + 1}"
  }
}


resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id                  = aws_vpc.codeserver_vpc.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "codeserver-private-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "codeserver_gw" {
  vpc_id = aws_vpc.codeserver_vpc.id

  tags = {
    Name = "codeserver_igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.codeserver_vpc.id

  tags = {
    Name = "codeserver-public_rt"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "codeserver-nat-eip"
  }
}

resource "aws_nat_gateway" "codeserver_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [aws_internet_gateway.codeserver_gw]

  tags = {
    Name = "codeserver-nat"
  }
}

resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.codeserver_gw.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.codeserver_vpc.id

  tags = {
    Name = "codeserver-private_rt"
  }
}

resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.codeserver_nat.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public_rt.id

}


resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_rt.id

}