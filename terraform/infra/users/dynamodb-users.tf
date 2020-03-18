resource "aws_dynamodb_table" "users" {
  name     = "${var.environment}-users"
  hash_key = "id"
  attribute {
      name = "id"
      type = "S"
  }
  write_capacity = "${var.write_capacity}"
  read_capacity  = "${var.read_capacity}"

  #Atributo para a criação do Global Secunday Index
  attribute{
    name = "email"
    type = "S"
  }
  global_secondary_index{
    name            = "${var.environment}-email-gsi" #Nome do hash_key do secundary index
    projection_type = "ALL" # Quais dados serão projetados na tabela
    hash_key        = "email" #É o nome do atribuito que foi definido, nome do hash_key do index
    write_capacity  = "${var.write_capacity}"
    read_capacity   = "${var.read_capacity}"
  }
}

resource "aws_dynamodb_table_item" "admin" {
  table_name = "${aws_dynamodb_table.users.name}"
  hash_key   = "${aws_dynamodb_table.users.hash_key}"

  item = <<ITEM
  {
  "id": {"S": "${var.admin_id}"},
  "email": {"S": "${var.admin_email}"},
  "password": {"S": "${var.admin_password}"},
  "role": {"S": "ADMIN"},
  "name": {"S": "${var.admin_name}"}
  }
  ITEM
}

resource "aws_ssm_parameter" "dynamodb_users_table" {
  name  = "${var.environment}-dynamodb-users-table"
  type  = "String"
  value = "${aws_dynamodb_table.users.name}"
}

#Exporta o index criado para o SSM
resource "aws_ssm_parameter" "email-gsi" {
  name  = "${var.environment}-email-gsi"
  type  = "String"
  value = "${var.environment}-email-gsi"
}


