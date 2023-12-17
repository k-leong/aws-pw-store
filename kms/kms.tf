resource "aws_kms_key" "kms" {
  description = "key for encrypt/decrypt"
  deletion_window_in_days = 7
  enable_key_rotation = true
}