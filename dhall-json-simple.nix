{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";
  version = "1.2.5";
  dhall-version = "1.19.1";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${dhall-version}/dhall-json-${version}-x86_64-linux.tar.bz2";
    sha256 = "0h896bs7r8bxxagzfivxiyk2h4aym7lw7sk7yc4kxh0fr5dzk03g";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -D -m555 -T dhall-to-json $out/bin/dhall-to-json
    install -D -m555 -T dhall-to-yaml $out/bin/dhall-to-yaml
  '';
}
