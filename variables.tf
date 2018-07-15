variable "region" {
  default = "eu-west-2"
}

variable "amis" {
  type = "map"

  default = {
    "us-east-1"      = "ami-b70554c8"
    "us-west-2"      = "ami-4b32be2b"
    "ap-northeast-1" = "ami-e99f4896"
    "eu-west-2"      = "ami-b8b45ddf"
  }
}

variable "availabilityZones" {
  type = "map"

  default = {
    "us-east-1"      = ["us-east-1a", "us-east-1b"]
    "us-west-2"      = ["us-west-2a", "us-west-2b"]
    "ap-northeast-1" = ["ap-northeast-1a", "ap-northeast-1b"]
    "eu-west-2"      = ["eu-west-2a", "eu-west-2b"]
  }
}
