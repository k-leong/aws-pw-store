# needs key admin policy. root to enable iam users
# needs key users policy

resource "aws_kms_key" "kms" {
  description             = "key for encrypt/decrypt"
  deletion_window_in_days = 7
  enable_key_rotation     = true
}

resource "aws_kms_alias" "kms_alias" {
  name          = "alias/kms-alias"
  target_key_id = aws_kms_key.kms.id
}

resource "aws_kms_key_policy" "kms_policy" {
  key_id = aws_kms_key.kms.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "lambda-key"
    Statement = [
      {
        Sid    = "Enable decrypt"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      # {
      #   Sid = "Enable encrypt"
      #   Effect = "Allow"
      #   Principal = {
      #     AWS = "*"
      #   }
      #   Action = ["kms:encrypt"]
      #   Resource = "*"
      # }
    ]
  })
}
