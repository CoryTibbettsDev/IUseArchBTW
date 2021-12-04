# IUseArchBTW
**CAUTION: This installation script will partition your drives deleting anything on them**<br  />
**Please read this script before running it! Running scripts from the internet before reading them is NOT a good idea.**<br  />
**Also I Use Arch BTW**<br  />
IUseArchBTW is an installation script for Arch and Artix Linux.
Supported init systems are systemd for Arch and openrc, runit, s6 and suite66 for Artix.
After the script runs stdout and stderr output is dumped into `out.log` and `err.log` files in the current working directory.
This script aims to be POSIX compliant so you can run it with bash, zsh, ksh or any other POSIX compliant shell.

# Usage
You can download the script with `curl` and then run it<br  />
`curl -O https://raw.githubusercontent.com/CoryTibbettsDev/IUseArchBTW/main/IUseArchBTW`<br  />
Run with `sh IUseArchBTW`<br  />
You can run the script over `ssh`<br  />
`ssh root@computer 'sh -s' < IUseArchBTW`<br  />
You can copy the script to another computer with `scp`<br  />
`scp IUseArchBTW root@computer:/root`<br  />

# Status
## Arch
### Tested
- systemd 2021.10.01
## Artix
### Tested
- openrc 20210726
### Untested
- runit
- s6
- suite66

# Useful Links
[Size of EFI Partition](https://askubuntu.com/questions/1313154/how-to-know-the-proper-amount-of-needed-disk-space-for-efi-partition)<br  />
[Alternative Partition Method with fdisk](https://superuser.com/questions/332252/how-to-create-and-format-a-partition-using-a-bash-script)<br  />
