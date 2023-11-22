variable "target_group_arn" {
  description = "arn of the target group"
  type        = string
  default     = "arn-123456789"
}

variable "alb_security_group_id" {
  description = "id of security group created for the alb"
  type        = string
  default     = "id-123456789"
}

variable "alb_subnets" {
  description = "list of Id from the public subnets"
  type        = list(string)
  default     = ["a", "b"]
}
