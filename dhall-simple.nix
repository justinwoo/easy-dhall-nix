{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-simple";
  version = "1.19.1";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${version}/dhall-${version}-x86_64-linux.tar.bz2";
    sha256 = "088qi8dsxwzyry8ws797kljpyyn18v6hfckvlw18q5bxkvxk0c83";
  };

  installPhase = ''
    mkdir -p $out/bin
    install -D -m555 -T dhall $out/bin/dhall
  '';
}
