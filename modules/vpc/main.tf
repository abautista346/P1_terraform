// here will be all my VPC resources

// Local varable
locals {
  
  myTags = {
    Owner   =   "abautista"
    Env     =   "p1"
  }

  SubnetID  =   ""
}

# Declare the data source---- this is to get all the AZ availables in our region
data "aws_availability_zones" "available" {
  state = "available"
}


//CREATING VPC
resource "aws_vpc" "abautista_vpc" {
  cidr_block  = var.vpc_cidr
  tags        = merge(local.myTags, {Name = "vpc_${var.environment}"})
}

###to concat values
# "<text> ${var.environment}"

// PUBLIC SUBNET
resource "aws_subnet" "sn_public" {
  count       = var.count_public_subnet
  vpc_id      = aws_vpc.abautista_vpc.id
  cidr_block  = cidrsubnet(var.vpc_cidr,8,1)

  tags        = merge(local.myTags, {Name = "${var.environment}_public-sn_${count.index + 1}"}) 

}
### method cidrsubnet
#>cidrsubnet("10.12.0.0/16", 8, 1)
#"10.12.1.0/24"
#> cidrsubnet("10.12.0.0/16", 8, 2)
#"10.12.2.0/24"
#> cidrsubnet("10.12.0.0/16", 8, 3)
#"10.12.3.0/24"


// PRIVATE SUBNET
resource "aws_subnet" "sn_private" {
  count       = var.count_private_subnet  
  vpc_id      = aws_vpc.abautista_vpc.id
  cidr_block  = cidrsubnet(var.vpc_cidr, 8, count.index + 1 + length(aws_subnet.sn_public))

  tags        = merge(local.myTags, {Name = "${var.environment}_priv-sn_${count.index + 1}"}) 
}


//INTERTER GATEWAY
resource "aws_internet_gateway" "abautista_IG" {
  vpc_id  = aws_vpc.abautista_vpc.id

  tags    = merge(local.myTags, {Name = "${var.environment}_IG"})
}


//PUBLIC ROUTE TABLE
resource "aws_route_table" "rt_public" {
  vpc_id = aws_vpc.abautista_vpc.id

  route {
    cidr_block = var.cidr_open
    gateway_id = aws_internet_gateway.abautista_IG.id
  }

  tags = merge(local.myTags, {Name = "${var.environment}_pub-RT"})
}

//RT public association
resource "aws_route_table_association" "rt_public_link" {
  count          = var.count_public_subnet
  subnet_id      = aws_subnet.sn_public[count.index].id

  route_table_id = aws_route_table.rt_public.id

}

//NAT GATEWAY
/*
resource "aws_nat_gateway" "abautista_NAT" {
  
  connectivity_type = "private"
  subnet_id         = aws_subnet.sn_public[count.index].id
}
*/

//PRIVATE ROUTE TABLE
resource "aws_route_table" "rt_private" {
  
  vpc_id = aws_vpc.abautista_vpc.id

/*
  route {
    cidr_block      = var.cidr_open
    nat_gateway_id  = aws_nat_gateway.abautista_NAT.id
  }
*/
  tags = merge(local.myTags, {Name = "${var.environment}_priv-RT"})
}

//RT private association
resource "aws_route_table_association" "rt_private_link" {
  count          = var.count_private_subnet
  subnet_id      = aws_subnet.sn_private[count.index].id
  route_table_id = aws_route_table.rt_private.id
}