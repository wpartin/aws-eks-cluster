data "aws_subnets" "these" {
  filter {
    name   = "default-for-az"
    values = [true]
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = [false]
  }
}