//here is my provider of service
//in this case AWS

terraform {
    required_providers {
      aws = {
        source  =   "hashicorp/aws"
        version =   "~> 4.0"
      }
    }
    //backend configuration to save in S3
    backend "s3" {
        bucket  = "bucket346-ncloud-training"
        key     = "terraform/p1state.tfstate"
        region  = "us-east-1"
    }
}

//configuration my AWS provider
provider "aws" {
<<<<<<< HEAD

    //region  =   "us-east-1"

=======
<<<<<<< HEAD
    ///region  =   "us-east-1" //old region changed  because here exist a problem with the number of resources
=======
    //region  =   "us-east-1"
>>>>>>> 4f841aa5040f5bcc5ec1e1a184f56bfa1f88143b
>>>>>>> 7d959339ed48bd879bbe41368bad0408c93a1b59
    region  = "us-west-2"
}
