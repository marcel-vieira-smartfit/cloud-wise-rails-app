# resource "aws_instance" "ubuntu" {
#   ami = "ami-0866a3c8686eaeeba"
#   instance_type = "t2.micro"
#   key_name = "marcel_m1_smart"
#   subnet_id = aws_subnet.public["us-east-1a"].id

#   credit_specification {
#     cpu_credits = "standard"
#   }

#   tags = {
#     Name = "Ubuntu"
#   }
# }
