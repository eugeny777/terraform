provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.zone}"
}

resource "aws_instance" "swarm_master" {
  ami  = "ami-0ff760d16d9497662"
  instance_type = "t2.micro"
  key_name = "ED"
  vpc_security_group_ids = ["${aws_security_group.firewall_instance.id}"]
  
  connection {
    type = "ssh"
    user = "centos"
    private_key="${file("YD.pem")}"
  }
  
  provisioner "file" {
    source      = "docker_install.sh"
    destination = "/tmp/docker_install.sh"
  }
  
  provisioner "file" {
    source      = "swarm_init.sh"
    destination = "/tmp/swarm_init.sh"
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo bash -x /tmp/docker_install.sh",
      "sudo bash -x /tmp/swarm_init.sh"
    ]
  }

  tags = {
    Name = "${var.Create_by}-swarm-master-${count.index}"
  }
}

resource "aws_instance" "swarm-worker" {
  ami           = "ami-0ff760d16d9497662"
  instance_type = "t2.micro"
  key_name = "ED"
  vpc_security_group_ids = ["${aws_security_group.firewall_instance.id}"]
  
  connection {
    type = "ssh"
    user = "centos"
    private_key="${file("YD.pem")}"
  }
  
  provisioner "file" {
    source      = "docker_install.sh"
    destination = "/tmp/docker_install.sh"
  }
  
  provisioner "file" {
  source      = "swarm_join.sh"
  destination = "/tmp/swarm_join.sh"
  }
  
  provisioner "remote-exec" {
    inline = [
	 "echo  \"${aws_instance.swarm_master.private_ip}  swarm_master\"|sudo tee -a  /etc/hosts",
     "sudo bash -x  /tmp/docker_install.sh",
     "sudo bash -x  /tmp/swarm_join.sh"
     ]
  }

 associate_public_ip_address = "false"
  tags = {
    Name = "${var.Create_by}-worker-${count.index}"
  }
}

resource "aws_instance" "jenkins-instance" {
  ami = "ami-0ff760d16d9497662"
  instance_type = "t2.micro"
  key_name = "ED"
  vpc_security_group_ids = ["${aws_security_group.firewall_instance.id}"]
  
  connection {
    type = "ssh"
    user = "centos"
    private_key="${file("YD.pem")}"
  }
  
  
  provisioner "file" {
    source      = "jenkins_install.sh"
    destination = "/tmp/jenkins_install.sh"
  }
  
  provisioner "remote-exec" {
    inline = [
    "echo  \"${aws_instance.swarm_master.private_ip}  swarm_master\"|sudo tee -a  /etc/hosts",
    "sudo bash -x /tmp/jenkins_install.sh"
    ]
  } 
 
  tags = {
    Name = "${var.Create_by}-jenkins"
  }
}
