#------------------
# Outputs
#------------------
output "connection_strings" {
  value = mongodbatlas_cluster.cluster.connection_strings[0].standard_srv
}

output "user" {
  value = mongodbatlas_database_user.user.username
}

output "ip_access_list" {
  value = mongodbatlas_project_ip_access_list.ip.ip_address
}

output "project_name" {
  value = mongodbatlas_project.project.name
}
