variable "db_identifier" {
  description = "provide db identifier"
  type        = string
}

variable "engine_type" {
  description = "provide engine type"
  type        = string
}

variable "instance_class" {
  description = "provide instance class"
  type        = string
}

variable "db_username" {
  description = "provide db username"
  type        = string

}

variable "db_password" {
  description = "provide password for this instance"
  type        = string
}

variable "allocated_storage" {
  description = "provide storage for this instance"
  type        = string
}

variable "engine_version" {
  description = "provide engine version"
  type        = string
}

variable "port" {
  description = "provide port"
  type        = string
}

variable "region" {
  description = "provide region"
  type        = string

}
