---
layout: post
title:  "Start blogging"
date:   2022-01-25 11:17:24 +0100
categories: jekyll update
---
# Bootstrapping under nixos

```fish
mkdir ngiger-jekyll
cd ngiger-jekyllo
nix-shell -p zlib bundler git ruby --command fish
jekyll new blog
Running bundle install in /opt/src/ngiger-jekyll/blog4...
Bundler: Skipping "bundle install" as it fails due to the Nix wrapper.
Bundler: Please enter the new directory and run the following commands to serve the page:
Bundler: nix-shell -p bundler --run "bundle install --gemfile=Gemfile --path vendor/cache"
Bundler: nix-shell -p bundler --run "bundle exec jekyll serve"
cd blog
bundler install
bundle exec jekyll server --port 4050
 ```

# Bootstrapping nixops version 2.0

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


# TODO: 

* https://kevq.uk/how-to-add-search-jekyll
* https://blog.webjeda.com/jekyll-search/

# More info about Jekyll (part of github-pages) used to build this site

Check out the [Jekyll docs][jekyll-docs] for more info on how to get the most out of Jekyll. File all bugs/feature requests at [Jekyll’s GitHub repo][jekyll-gh]. If you have questions, you can ask them on [Jekyll Talk][jekyll-talk].

[jekyll-docs]: https://jekyllrb.com/docs/home
[jekyll-gh]:   https://github.com/jekyll/jekyll
[jekyll-talk]: https://talk.jekyllrb.com/
