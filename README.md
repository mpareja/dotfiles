# Mario's dotfiles

This repository has all of my command line configuration files. It can be installed by cloning the repository and running `install.sh`:

```
git clone https://github.com/mpareja/dotfiles.git
cd dotfiles
./install.sh
```

# Ubuntu full-system install

This repository also has scripts for setting up a Ubuntu workstation. In addition to installing `dotfiles`, it will install packages I use and setup GitHub SSH keys, etc.. This one-line will execute the installation on a fresh Ubuntu machine:

    bash <(wget -q -O - https://raw.github.com/mpareja/dotfiles/master/ubuntu/bootstrap.sh)
