terraform {
  backend "s3" {
    bucket = "glab-terraform"
    key    = "lab/state"
    region = "us-west-2"
  }
}