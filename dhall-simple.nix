{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-1.29.0-x86_64-macos.tar.bz2";
    sha256 = "0liqfhvwbpjykrcd547f6814zzgc4rhilfk42jr0h24557ivcfj6";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-1.29.0-x86_64-linux.tar.bz2";
    sha256 = "1lamg0vli5r9lshxg40nysirvn264hk3w9zk7hcar6lihcxdnwz2";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL=$out/bin/dhall
    install -D -m555 -T dhall $DHALL

    mkdir -p $out/etc/bash_completion.d/
    $DHALL --bash-completion-script $DHALL > $out/etc/bash_completion.d/dhall-completion.bash
  '';
}
