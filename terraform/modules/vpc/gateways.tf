resource "aws_internet_gateway" "public_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "${var.project_name}-public-igw"
  }
}

resource "aws_eip" "nat_gw_ips" {
  count = var.num_private_subnets
  vpc   = true

  tags = {
    Name  = "${var.project_name}-private-nat-gw-ip-${var.region_azs[count.index]}"
  }
}

resource "aws_nat_gateway" "private_nat_gws" {
  count         = var.num_private_subnets
  
  allocation_id = aws_eip.nat_gw_ips[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = {
    Name         = "${var.project_name}-nat-gw-${var.region_azs[count.index]}"
  }
  depends_on = [aws_internet_gateway.public_igw]
}