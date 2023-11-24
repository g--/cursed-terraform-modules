
data "external" "whoami" {
  program = [
    "bash",
    "-c",
    <<EOT
	echo {\"ip\": \"`dig +short myip.opendns.com @resolver1.opendns.com`\", \"user\": \"`whoami`\", \"hostname\": \"`hostname`\"}
EOT
  ]
}


