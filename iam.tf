resource "aws_iam_instance_profile" "pete_test_profile" {
  name = "pete_test_profile"
  role = "${aws_iam_role.pete_s3_access.name}"
}

resource "aws_iam_role" "pete_s3_access" {
  name = "pete_s3_access"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = "${aws_iam_role.pete_s3_access.name}"
  policy_arn = "${data.aws_iam_policy.S3FullAccess.arn}"
}

data "aws_iam_policy" "S3FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

#resource "aws_iam_role_policy" "pete_s3_policy" {
#  name = "pete_s3_policy"
#  role = "${aws_iam_role.pete_s3_access.id}"


#  policy = <<EOF
#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#            "Action": "s3:*",
#            "Resource": "*"
#        }
#    ]
#}
#EOF
#}

