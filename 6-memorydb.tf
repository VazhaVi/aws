module "memory_db" {
  source = "terraform-aws-modules/memory-db/aws"
  version = "1.1.2"
  # Cluster
  name        = "lab"
  description = "Lab MemoryDB cluster"

  engine_version             = "6.2"
  auto_minor_version_upgrade = true
  node_type                  = "db.t4g.small"
  num_shards                 = 1
  num_replicas_per_shard     = 1

  tls_enabled              = true
  security_group_ids       = ["sg-073d08d5f993e167f"]
  maintenance_window       = "sun:23:00-mon:01:30"

  snapshot_retention_limit = 1
  snapshot_window          = "05:00-09:00"

  # Users
  users = {
    admin = {
      user_name     = "admin-user"
      access_string = "on ~* &* +@all"
      passwords     = ["YouShouldPickAStrongSecurePassword987!"]
      tags          = { User = "admin" }
    }
    readonly = {
      user_name     = "readonly-user"
      access_string = "on ~* &* -@all +@read"
      passwords     = ["YouShouldPickAStrongSecurePassword123!"]
      tags          = { User = "readonly" }
    }
  }

  # ACL
  acl_name = "lab-acl"
  acl_tags = { Acl = "custom" }

  # Parameter group
  parameter_group_name        = "lab-param-group"
  parameter_group_description = "Lab MemoryDB parameter group"
  parameter_group_family      = "memorydb_redis6"
  parameter_group_parameters = [
    {
      name  = "activedefrag"
      value = "yes"
    }
  ]
  parameter_group_tags = {
    ParameterGroup = "custom"
  }

  # Subnet group
  subnet_group_name        = "lab-subnet-group"
  subnet_group_description = "Lab MemoryDB subnet group"
  subnet_ids               = module.vpc.private_subnets
  subnet_group_tags = {
    SubnetGroup = "custom"
  }

  tags = {
    Terraform   = "true"
    Environment = "lab"
  }
}