resource "aws_network_interface" "bastion-interface" {
    subnet_id = aws_subnet.app-subnet[0].id
    private_ips = ["10.10.0.10"]
    description = "Static ip for bastion host"
    security_groups = [aws_security_group.bastion-sg.id]
    tags = merge(
      local.custom_tags,
      {
        type = "network"
        app = "bastion"
      }
    )
}

resource "aws_security_group" "bastion-sg" {
  name = "bastion-sg"
  description = "Security group for bastion"
  vpc_id = aws_vpc.prod-vpc.id


  ingress {
    description = "SSH dummy rule"
    from_port = 0
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Bastion outgoing rule"
    from_port = 0
    protocol = "tcp"
    to_port = 0
  }
  tags = merge(
    local.custom_tags,
    {
      type = "network"
      app = "bastion"
    }
  )
}