# Helper script for Niklaus to be able to work under NixOS
# To get into a fish shell call in this directory: nix-shell --command fish
{ pkgs ? import <nixpkgs> {} }:
 pkgs.mkShell {
  buildInputs = [ pkgs.zlib pkgs.git pkgs.bundler pkgs.ruby.devEnv pkgs.bundix
  ];
}
