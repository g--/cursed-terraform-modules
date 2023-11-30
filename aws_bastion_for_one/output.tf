# not strictly "output" resources, but definately output.
resource "local_file" "bastion_ssh" {
  filename        = "bastion_ssh"
  file_permission = "0755"

  content = <<EOT
#!/bin/sh

cat - <<END_OF_GREETING
${var.shell_script_greeting}
END_OF_GREETING
ssh -A ${local.default_username}@${aws_instance.landing_pad.public_ip}
EOT
}

