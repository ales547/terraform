provider "aws" {
  // access_key = "AWS_ACCESS_KEY_ID" user's access key
  // secret_key = "AWS_SECRET_ACCESS_KEY" users's secret key
  // or via environment variables
  region = "eu-west-1" //aws region AWS_DEFAULT_REGION
}


resource "aws_instance" "ubuntu" {
  count         = 1                       // count of created instances
  ami           = "ami-07d8796a2b0f8d29c" // ID of AWS AMI
  instance_type = "t2.micro"              //type of instance

  tags = {
    Name    = "Ubuntu Server"
    Owner   = "Alexandr Butylin"
    Project = "Hren ego znaet"
  }
}
