with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "env";
  buildInputs = [ pkgs.zlib pkgs.git pkgs.bundler pkgs.ruby.devEnv pkgs.bundix
  ];
}
