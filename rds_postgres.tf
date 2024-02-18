resource "aws_db_instance" "ropa-postgres-db" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "15"
  identifier           = "ropa-postgres-db"
  instance_class       = "db.t3.micro"
  password             = var.rds_ropa_pass
  skip_final_snapshot  = true
  storage_encrypted    = false
  publicly_accessible  = true
  username             = var.rds_ropa_username
  apply_immediately    = true
}

/*
provider "postgresql" {
  host            = aws_db_instance.ropa-postgres-db.address
  port            = 5432
  username        = aws_db_instance.ropa-postgres-db.username
  password        = aws_db_instance.ropa-postgres-db.password
  sslmode         = "require"
  connect_timeout = 15
}

resource "postgresql_schema" "ropa-main" {
  name = "ropa_main_db"
}

output "rds_address" {
  description = "RDS address"
  value       = aws_db_instance.ropa-postgres-db.address
}
*/

