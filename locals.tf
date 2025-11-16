locals {
  common_name_suffix="${var.project_name}-${var.environment}"
  ami_id=data.aws_ami.devops_ami_id.id
  vpc_id=data.aws_ssm_parameter.vpc_id.value
  private_subnet_id=split("," , data.aws_ssm_parameter.private_subnet_ids.value)[0]
  private_subnet_ids=split("," , data.aws_ssm_parameter.private_subnet_ids.value)
  backend_alb_listener_arn=data.aws_ssm_parameter.backend_alb_listener_arn.value
  frontend_alb_listener_arn=data.aws_ssm_parameter.frontend_alb_listener_arn.value
  listener_arn= "${var.component}" == "frontend" ? local.frontend_alb_listener_arn : local.backend_alb_listener_arn
  sg_id=data.aws_ssm_parameter.sg_id.value
  tg_port= "${var.component}" == "frontend" ? 80 : 8080
  health_check_path= "${var.component}" == "frontend" ? "/" : "/health"
  host_context_path= "${var.component}" == "frontend" ? "${var.project_name}-${var.environment}.${var.domain_name}" : "${var.component}.backend-alb-${var.environment}.${var.domain_name}"
  common_tags={
    project_name= var.project_name
    environment= var.environment
    terraform= true
}
}