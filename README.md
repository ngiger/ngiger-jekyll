

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

# TODO: 

* https://kevq.uk/how-to-add-search-jekyll
* https://blog.webjeda.com/jekyll-search/
