resource "aws_security_group" "rds_sg" {
  name = "rds_sg"
  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "ropa-postgres-instance" {
  allocated_storage    = 10
  engine               = "postgres"
  engine_version       = "15"
  identifier           = "ropa-postgres-instance"
  instance_class       = "db.t3.micro"
  password             = var.rds_ropa_pass
  skip_final_snapshot  = true
  storage_encrypted    = false
  publicly_accessible  = true
  username             = var.rds_ropa_username
  vpc_security_group_ids = ["${aws_security_group.rds_sg.id}"]
  apply_immediately    = true
}

# Split on another file
provider "postgresql" {
  host            = aws_db_instance.ropa-postgres-instance.address
  port            = 5432
  username        = aws_db_instance.ropa-postgres-instance.username
  password        = aws_db_instance.ropa-postgres-instance.password
  sslmode         = "require"
  connect_timeout = 15
}

resource "postgresql_database" "ropa-postgres-db" {
  name              = "ropa-postgres-db"
  owner             = "postgres"
  template          = "template0"
  lc_collate        = "C"
  connection_limit  = -1
  allow_connections = true
}

#resource "postgresql_schema" "ropa-main" {
#  name = "ropa_main_db"
#}


output "security_group_id" {
  value       = aws_security_group.rds_sg.id
}

output "db_instance_endpoint" {
  value       = aws_db_instance.ropa-postgres-instance.endpoint
}

output "rds_address" {
  description = "RDS address"
  value       = aws_db_instance.ropa-postgres-instance.address
}

