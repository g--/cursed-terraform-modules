output "ip" {
  value = data.external.whoami.result.ip
}

output "username" {
  value = data.external.whoami.result.user
}

output "hostname" {
  value = data.external.whoami.result.hostname
}

