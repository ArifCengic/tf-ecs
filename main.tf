
resource "aws_launch_configuration" "test-ecs-launch-configuration" {
    name = "test-ecs-launch-configuration"
    image_id = "ami-aff65ad2" #ECS AMI for us-east-1
    instance_type = var.instance_type 
    security_groups = [var.security_group_id]
    #iam_instance_profile = aws_iam_instance_profile.ecs-instance-profile.id
    iam_instance_profile = "arn:aws:iam::064777359940:instance-profile/ECS-APP-Role" #hardcoded 
    root_block_device {
        volume_type = "standard"
        volume_size = 100
        delete_on_termination = true
    }

    lifecycle {
        create_before_destroy = true
    }

    associate_public_ip_address = "true"
    key_name = "MyKeyPair"

    # register the cluster name with ecs-agent which will in turn coord
    # with the AWS api about the cluster
    #
    user_data                   = <<EOF
                                  #!/bin/bash
                                  echo ECS_CLUSTER=${var.ecs_cluster_name} >> /etc/ecs/ecs.config
                                  EOF
}


resource "aws_autoscaling_group" "test-ecs-autoscaling-group" {
    name = "test-ecs-autoscaling-group"
    max_size = var.max_size
    min_size = var.min_size
    desired_capacity = var.desired_capacity

    vpc_zone_identifier = var.vpc_public_subnets 
    launch_configuration = aws_launch_configuration.test-ecs-launch-configuration.name
    # health_check_type = "ELB"
    health_check_type = "EC2"

        tag {
            key = "Name"
            value = var.ecs_cluster_name
            propagate_at_launch = true
        }
}

resource "aws_ecs_cluster" "test-ecs-cluster" {
    name = var.ecs_cluster_name
}
#----------------------- ECS -------------------------