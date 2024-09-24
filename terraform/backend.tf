terraform {
 backend "s3" {
   bucket         = "how2web-tfstate"
   key            = "terraform.tfstate"
   region         = "eu-central-1"
  #  dynamodb_table = "las-terraform-state-locks"
 }
}