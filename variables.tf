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
