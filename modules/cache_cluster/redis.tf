locals {
  ports = join(" ", var.ports)
}

resource "aws_cloudwatch_log_group" "log_group_slowly" {
  name = "redis/${var.common.env}-${var.common.project}-ugc_slowly"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "log_group_engine" {
  name = "redis/${var.common.env}-${var.common.project}-ugc_engine"
  retention_in_days = 7
}

resource "aws_elasticache_replication_group" "redis_cluster" {
  replication_group_id       = "${var.common.env}-${var.common.project}"
  node_type                  = var.node_type
  port                       = var.ports[0]
  engine                     = var.engine
  engine_version             = var.redis_engine_version
  parameter_group_name       = var.parameter_group_name
  automatic_failover_enabled = true

  num_node_groups         = 2
  replicas_per_node_group = 1

  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.log_group_slowly.name
    destination_type = "cloudwatch-logs"
    log_format       = "text"
    log_type         = "slow-log"
  }
  log_delivery_configuration {
    destination      = aws_cloudwatch_log_group.log_group_engine.name
    destination_type = "cloudwatch-logs"
    log_format       = "json"
    log_type         = "engine-log"
  }
}

resource "aws_elasticache_subnet_group" "cache_subnet_group" {
    name = "${var.common.env}-${var.common.project}"
    subnet_ids = var.network.subnet_ids
}

resource "aws_security_group_rule" "sg_rule_redis" {
  count = length(var.ports)
  type = "ingress"
  # from_port = var.port
  # to_port = var.port
  from_port = var.ports[count.index]
  to_port = var.ports[count.index]
  protocol = "TCP"
  cidr_blocks = ["0.0.0.0/0"]
  #source_security_group_id = var.network.sg_container
  security_group_id = aws_security_group.sg_redis.id
}

resource "aws_security_group" "sg_redis" {
  name = "${var.common.env}-${var.common.project}-sg-redis"
  vpc_id = var.network.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}