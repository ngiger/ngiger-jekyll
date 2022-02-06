---
layout: post
title:  "Patching a nix package"
date:   2022-02-05 11:17:24 +0100
categories: nixops
---

# Adding ruby-gem postrunner

See https://github.com/ngiger/nixpkgs/commit/4a230aa1f018a9f8c7708855d2c4e7047150d512
and https://nixos.wiki/wiki/Nixpkgs/Create_and_debug_packages


## Notes on running a test

Added in `default.nix` the lines 

```
passthru.tests = {
    simple-execution = callPackage ./tests.nix { };
  };
passthru.tests = {
    simple-execution = callPackage ./tests.nix { };
  };
```

Where `tests.nix` is quite simple

```
{ runCommand, postrunner, stdenv }:

let
  inherit (postrunner) name;
  version = (import ./gemset.nix).postrunner.version;
in

runCommand "${name}-tests" { meta.timeout = 3; }
  ''
    # get version of installed program and compare with package version
    if [[ `${postrunner}/bin/postrunner version` != *"${version}"*  ]]; then
      echo "Error: program version does not match package version"
      exit 1
    fi
    # run help
    ${postrunner}/bin/postrunner --help | grep 'Usage postrunner .command. .options.'
    echo All test for $name passed
    # needed for Nix to register the command as successful
    touch $out
  ''
```

To install the package I called
```
export NIXPKGS=$PWD # in my checkout of nixpkgs
nix-env -f $NIXPKGS -iA rubyPackages.postrunner
nix-build -A postrunner.tests # to run the tests
nix-build -A postrunner
```

To update to a new version of postrunner I used
```
cd pkgs/applications/misc/postrunner # in  my git checkout
nix-shell -p bundler zlib --run "bundle update postrunner"
nix-shell -p bundler zlib --run "bundix"
cd ../../../.. # get back to the root of my git checkout
nix-build $PWD -A postrunner.tests # to run the tests
nix-build $PWD -A postrunner
result/bin/postrunner --version # to check the output
```

As I am using flakes for my setup the following steps are needed to install the
new postrunner exe in my setup
```
cd /etc/nixos
nix flake update
sudo nixos-rebuild test --flake '.#librem'
```

```
nixops create -d nuc
cd /etc/nixos/hosts/nuc
nixops deploy -d nuc --test
# test the system and if everythins is okay install and reboot
nixops deploy -d nuc --boot
nixops deploy -d nuc --force-reboot
```

Hatte die Fehlermeldung `nuc> warning: unable to download 'https://cache.nixos.org/nix-cache-info': Couldn't resolve host name (6); retrying in 276 mss`
Gelöst mit `rm $HOME/.cache/nix/binary-cache-v*.sqlite*` auf `nuc`
https://oddco.de/post/private-server/

## Ideas for storing secrets

See https://christine.website/blog/nixos-encrypted-secrets-2021-01-20
    pkgs.age # https://github.com/FiloSottile/age 
    age is a simple, modern and secure file encryption tool, format, and Go library.
