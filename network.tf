resource "aws_vpc" "aws_basic_app" {
  cidr_block = "10.0.0.0/18"

  tags = {
    Name = "aws_basic_app"
  }
}

resource "aws_internet_gateway" "aws_basic_app" {
  vpc_id = aws_vpc.aws_basic_app.id
}

// -------------------------------------- public subnets --------------------------------------
resource "aws_subnet" "public_subnet_a" {
  vpc_id     = aws_vpc.aws_basic_app.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-southeast-1a"
  
  tags = {
    Name = "public_subnet_a"
  }
}

resource "aws_subnet" "public_subnet_b" {
  vpc_id     = aws_vpc.aws_basic_app.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-southeast-1b"
  
  tags = {
    Name = "public_subnet_b"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.aws_basic_app.id

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route" "public_subnet_route" {
  route_table_id = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.aws_basic_app.id
}

resource "aws_route_table_association" "public_subnet_a" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id = aws_subnet.public_subnet_a.id
}

resource "aws_route_table_association" "public_subnet_b" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id = aws_subnet.public_subnet_b.id
}

// ---------------------------------------- private subnets -----------------------------
resource "aws_eip" "nat_ip" {
  tags = {
    Name = "nat_ip"
  }
}

resource "aws_nat_gateway" "nat" {
  subnet_id = aws_subnet.public_subnet_a.id
  allocation_id = aws_eip.nat_ip.id

  tags = {
    Name = "nat"
  }
}

resource "aws_subnet" "private_subnet_a" {
  vpc_id     = aws_vpc.aws_basic_app.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-southeast-1a"
  
  tags = {
    Name = "private_subnet_a"
  } 
}

resource "aws_subnet" "private_subnet_b" {
  vpc_id     = aws_vpc.aws_basic_app.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-southeast-1b"
  
  tags = {
    Name = "private_subnet_b"
  } 
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.aws_basic_app.id

  tags = {
    Name = "private_rt"
  }
}

resource "aws_route_table_association" "private_subnet_a" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id = aws_subnet.private_subnet_a.id
}

resource "aws_route_table_association" "private_subnet_b" {
  route_table_id = aws_route_table.private_rt.id
  subnet_id = aws_subnet.private_subnet_b.id
}

resource "aws_route" "private_subnet_route" {
  route_table_id = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}

