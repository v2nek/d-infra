locals {
  networks_function = cidrsubnets(var.cidr, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6)
  networks = {
    #            10.x.0.0/22                    10.x.4.0/22                 10.x.8.0/22
    private = [local.networks_function[0], local.networks_function[1], local.networks_function[2]]
    #            10.x.12.0/22                    10.x.16.0/22                 10.x.20.0/22
    public = [local.networks_function[3], local.networks_function[4], local.networks_function[5]]
    #            10.x.24.0/22                    10.x.28.0/22                 10.x.32.0/22
    database = [local.networks_function[6], local.networks_function[7], local.networks_function[8]]
    #
    services = "172.20.0.0/16"

  }

  azs = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
}
