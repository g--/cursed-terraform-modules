# Cursed TF modules

please, for the love of all that is good, don't use this in production or anywhere really.


But if you do:

## bastion for one

```
module "bastion" {
  source = "git::https://github.com/g--/cursed-terraform-modules//aws_bastion_for_one"
  vpc_id = #REPLACE ME
  subnet_id = #REPLACE ME
  key_name = #REPLACE ME
  shell_script_greeting = "the test instances are currently .. somewhere?"
}
```

Afterwards, run:
```
./bastion_ssh
```

## what is my ip anyways?

```
module "whoami" {
  source = "git::https://github.com/g--/cursed-terraform-modules//whats_my_ip"
}

# now use module.whoami.ip, module.whoami.username, module.whoami.hostname
```


