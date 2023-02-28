provider "aws" {
    region = "us-east-1"
    access_key = "AKIAQFNXUMSM4DSXGDME"
    secret_key = "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"
}

resource "aws_instance" "tfi" {
    ami = "ami-04505e74c0741db8d"
    instance_type = "t2.micro"
    key_name = "tcw"  
}