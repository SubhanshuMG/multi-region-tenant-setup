
resource "aws_db_instance" "postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "13"
  instance_class       = "db.t3.micro"
  name                 = var.db_name
  username             = var.db_user
  password             = var.db_password
  vpc_security_group_ids = [aws_security_group.db.id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  multi_az             = false
  publicly_accessible  = false
  tags = {
    Name = "Postgres-DB-${var.region}"
  }
}
                