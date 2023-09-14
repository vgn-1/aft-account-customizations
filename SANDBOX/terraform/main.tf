resource "aws_budgets_budget" "total_cost" {
  name              = "budget-total-monthly"
  budget_type       = "COST"
  limit_amount      = "100"
  limit_unit        = "USD"
  time_period_end   = "2087-06-15_00:00"
  time_period_start = "2022-02-01_00:00"
  time_unit         = "MONTHLY"
}

resource "aws_ssm_parameter" "fooapse2" {
  name  = "foo"
  type  = "String"
  value = "bar"
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_function" "lambda_for_kms" {
  function_name = "my-test-function-from-AFT"
  description = "my-test-function-from-AFT"
  handler = "index.lambda_handler"
  runtime = "python3.10"
  architectures = ["arm64"]
  timeout = "5"
  filename = "index.zip"
  role = aws_iam_role.iam_for_lambda.arn
}
