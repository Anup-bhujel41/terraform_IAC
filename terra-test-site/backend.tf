#store terraform state file in S3

terraform {
  backend "s3" {

    #bucket name
    bucket      =

    #projectname.tfstate 
    key         = "terra-test-site.tfstate"

    #region used for the project
    region      = 

    #profile configured with accesskey and secret key of aws
    profile      = 
  }
}