#=================common=======================
project = "geotechnologies-ugc-app"
env = "dev"
region = "us-east-1"
account_id = "115228050885"

#=================ECR=========================
image_tag_mutability = "MUTABLE"


#=======================EC2=================================
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3HN1YSS1zIQ01goxSEwpgfq5rhqJy0RKKhwrL8aD/fK4z9XpXOyQFkiyoSfbdAxD8LRZJNoZtRINRjN1G1pQ9xSzWYGrM0SjtBW/sQw2v40Pdn8Tda4dHf3EVOWISUboRjpOR9eZuhmHKqgjO8u+TRUHOUCuFxjEypwu0YTI7rg8nro9GrOqmR/Ayyw6v3hYyltbS+gij7GWXVwb89HznaGfM3jU6xU7SVxlcxVpCpjB9+x5sXILBu3scCcUvMM3NPzMSmLwnfQtETE8A7kRuWW+MrGBUFH7rXN1zoYLqCUIUEk+DSMxlZ8gc6hBlViDmUKxfdz8HkTiGHVE+rrJYz7M32gaG/Ukk9BunEIU/oYE1XxIjhXOszEm9MP3uWk1fywcY8y4QE328vAOLkUJVte5CyC6aUOTvOV9uImsbCdwB359QSK7c+pSLTc1eSyQSZasbNLpJrTFVyE4eWgaA07lGTlPKoxMaPF7idw2MWuzvGUMpC7i3+psLvMtksqU="


#=======================redis cache=====================================
redis_engine_version = "redis"
num_cache_nodes = "1"
node_type = "cache.t4g.medium"
ports = ["6379"]


#=======================rds=====================================
rds_port = "3306"
rds_family = "mysql8.0"
rds_engine = "mysql"
rds_engine_version = "8.0.35"
rds_name = "api"
rds_class = "db.t3.micro"
rds_strorage = "10"


#========================ssm=====================================
source_services = ["api"]

#=======================ACM=====================================
#domain_name_lb = ["test1.devops.donnytran.com", "test2.devops.donnytran.com"]
domain_name_lb = "devops.donnytran.com"

#========================route53cdn============================
hosted_zone_public_id = "Z06779651QZ4JN1GLQ0XR"
#domain_name = "khai.devops.donnytran.com"
domain_name_cf = "devops.donnytran.com"

#========================route53lb=================
lb_domain_name = "lb.sotatek.com"
lb_hosted_zone_id = "zone_id_test"


#=======================cf-cdn=========================
cdn_domain = "cdn.sotatek.com"


#=======================cf-fe=========================
cf_cert_arn = "arn:aws:acm:us-east-1:115228050885:certificate/230f0f65-1658-4493-89d6-47922ce4c896"
domain_cf_fe = "fe.devops.donnytran.com"
domain_cf_static = "static.devops.donnytran.com"

#=======================ecs-base===============================


#=======================ecs-scale===============================
ecs_service = [
  {
    service_name = "testingservice"
    container_name = "ugc-container" 
    command = "pwd"
    container_port = "80"
    desired_count = "1"
    task_cpu = "512"
    task_ram = "2048"
    min_containers = "1"
    max_containers = "1"
    auto_scaling_target_value_cpu = "2"
    auto_scaling_target_value_ram = "4"
  }
]

#========================VPC=====================================
vpc_cidr = "172.16.0.0/16"
public_subnet_numbers = {
  "us-east-1a" = 1
  "us-east-1c" = 2
}
private_subnet_numbers = {
  "us-east-1a" = 4
  "us-east-1c" = 5
}

#=======================CI/CD====================================
codebuild_image = "BUILD_GENERAL1_SMALL"
codebuild_compute_type = "aws/codebuild/standard:5.0"
github_repos = [
  { 
    service = ["testingservice"],
    name = "testingnewpipeline", 
    branch="main", 
    organization="Sotatek-KhaiNguyen",
    buildspec_variables=[
      {
        key   = "REPOSITORY_URI"
        value = "115228050885.dkr.ecr.us-east-1.amazonaws.com/dev-geotechnologies-ugc-app-ugc-container"
      }
    ] 
  }
]

#=========================ACM for lb==================================
dns_cert_arn = "arn:aws:acm:us-east-1:115228050885:certificate/0c9c7e80-e373-4089-9087-857adaa5ab9e"


#==========================target group===============================
health_check_path = "/"
host_header = "khai.devops.donnytran.com"
priority = "100"