terraform {
   backend "s3" {
     bucket = "srchach-base"
     key    = "apps"
     region = "us-east-2"
     dynamodb_table = "srchach-dynamotf"
   }
}

