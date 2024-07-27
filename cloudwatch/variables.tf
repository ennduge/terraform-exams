variable "log_group_name" {
  description = "The name of the CloudWatch log group"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "provide region for this cloudwatch"
  type        = string

}


