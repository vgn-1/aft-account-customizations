resource "aws_ssm_parameter" "fooapse2" {
  name  = "foo"
  type  = "String"
  value = "bar"
}