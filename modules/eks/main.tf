resource "aws_eks_cluster" "cluster18" {
  name     = "AWS-EKS"
  role_arn = var.masterrole

  vpc_config {
    subnet_ids = [var.public_subnet_az1_id, var.public_subnet_az2_id]
  }

  tags = {
    Name = "AWS-EKS"
  }
}

resource "aws_eks_node_group" "node-grp" {
  cluster_name    = aws_eks_cluster.cluster18.name
  node_group_name = "Worker-Node-Group"
  node_role_arn   = var.worker_arn
  subnet_ids      = [var.public_subnet_az1_id, var.public_subnet_az2_id]
  capacity_type   = "ON_DEMAND"
  disk_size       = 20
  instance_types  = [var.instance_size]

  remote_access {
    ec2_ssh_key               = "jabbar"
    source_security_group_ids = [var.eks_security_group_id]
  }

  labels = {
    env = "Prod"
  }

  scaling_config {
    desired_size = var.worker_node_count
    max_size     = var.worker_node_count
    min_size     = var.worker_node_count
  }

  update_config {
    max_unavailable = 1
  }
}