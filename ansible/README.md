# Setup

1. Create an inventory file: `cp sample.inventory.ini inventory.ini`
2. Add hostname to the appropriate inventory.ini sections
3. `./playbook.yml --connection=local`

## Update APT Repository signing keys

```bash
curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | \
  sudo gpg --dearmor --yes -o ./roles/workstation/files/apt/trusted.gpg.d/spotify.gpg
```
