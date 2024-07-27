variable "topic_name" {
  description = "The name of the SNS topic"
  type        = string
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}

variable "region" {
  description = "provide a region for this SNS topic"
  type        = string
}
