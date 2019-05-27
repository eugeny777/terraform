resource "aws_security_group" "firewall_instance" {
    name = "firewall"
    description = "Firewall scurity policies."

    ingress {
        from_port = 0
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
      from_port = 2376
      to_port = 2376
      protocol = "tcp"
      cidr_blocks = ["172.0.0.0/8"]
    }
    
    ingress {
      from_port = 2377
      to_port = 2377
      protocol = "tcp"
      cidr_blocks = ["172.0.0.0/8"]
    }
    
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}