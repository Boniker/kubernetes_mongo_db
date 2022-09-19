#------------------
# Providers
#------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0.0, < 4.0.0"
    }
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "1.3.1"
    }
  }
  required_version = ">= 0.13"
}

provider "mongodbatlas" {
  public_key  = var.public_key
  private_key = var.private_key
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      tool      = "aws"
      terrafrom = "True"
    }
  }
}

#------------------
# Atlas Cluster
#------------------
resource "mongodbatlas_cluster" "cluster" {
  project_id             = mongodbatlas_project.project.id
  name                   = var.cluster_name
  mongo_db_major_version = var.mongodbversion
  cluster_type           = "REPLICASET"
  replication_specs {
    num_shards = 1
    regions_config {
      region_name     = var.region
      electable_nodes = 3
      priority        = 7
      read_only_nodes = 0
    }
  }
  cloud_backup                 = true
  auto_scaling_disk_gb_enabled = true
  provider_name                = var.cloud_provider
  provider_instance_size_name  = "M10"
}

#------------------
# Database User
#------------------
resource "mongodbatlas_database_user" "user" {
  username           = var.dbuser
  password           = var.dbuser_password
  project_id         = mongodbatlas_project.project.id
  auth_database_name = "admin"

  roles {
    role_name     = "readWrite"
    database_name = var.database_name
  }
  labels {
    key   = "Name"
    value = "DB User1"
  }
}

#------------------
# IP Access List
#------------------
resource "mongodbatlas_project_ip_access_list" "ip" {
  project_id = mongodbatlas_project.project.id
  ip_address = var.ip_address
  comment    = "IP Address for accessing the cluster"
}

#------------------
# Project
#------------------
resource "mongodbatlas_project" "project" {
  name   = var.project_name
  org_id = var.org_id
}
