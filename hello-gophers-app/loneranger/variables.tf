# Inject MySQL config, omit VPC ID and Subnet IDs
variable "mysql_config" {
  description = "The config for the MySQL DB"

  type = object({
    address = string
    port    = number
  })
  default = {
    address = "mock-db-address"
    port = 10293
  }
}