## Initial Setup

1. Bootstrap dotfiles and prerequisite packages

   ```bash
   bash <(wget -q -O - https://raw.github.com/mpareja/dotfiles/master/ubuntu/bootstrap.sh)
   ```

   If you're not Mario, you can override the git settings:
   ```bash
    GIT_USERNAME=mpareja GIT_EMAIL=pareja.mario@bogusmail.com bash <(wget -q -O - https://raw.github.com/mpareja/dotfiles/master/ubuntu/bootstrap.sh)
   ```

1. Enable connecting locally (`ssh <hostname>`) by running: `ssh-copy-id <hostname>`

1. Create an inventory file: `cp sample.inventory.ini inventory.ini`

1. Add hostname to the appropriate inventory.ini sections

1. Create `host_vars/<hostname>.yml` based on `sample.host.yml`

1. `./playbook.yml --connection=local` (`-C` for a dry-run)

### Next Steps

1. Configure Vim

## Maintenance

### Update APT Repository signing keys

```bash
curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | \
  sudo gpg --dearmor --yes -o ./roles/workstation/files/apt/trusted.gpg.d/spotify.gpg
```
