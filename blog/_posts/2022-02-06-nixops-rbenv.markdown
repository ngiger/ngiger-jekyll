---
layout: post
title:  "Using rbenv under NixOS"
date:   2022-02-06 12:23:24 +0100
categories: nixops
---

# Adding rbenv

```
nix-env -iA nixos.rbenv 
echo "status --is-interactive; and source (rbenv init -|psub)" | tee --append ~/.config/fish/config.fish
mkdir -p ~/.rbenv/plugins
cd  ~/.rbenv/plugins
git clone https://github.com/rbenv/ruby-build
nix-shell -p openssl readline bundler

rbenv install 3.1.0
# autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
```
