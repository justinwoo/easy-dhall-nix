{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.28.0/dhall-1.28.0-x86_64-macos.tar.bz2";
    sha256 = "19c6qs01hfcb39bxqwxsagv69bwkp8k6pnvz8gnq197k3yyzw9xm";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.28.0/dhall-1.28.0-x86_64-linux.tar.bz2";
    sha256 = "1s5ln7bpv0186nayw6h2wswc3js3262adrqx7f72k0sa70kjmksq";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL=$out/bin/dhall
    install -D -m555 -T dhall $DHALL

    mkdir -p $out/etc/bash_completion.d/
    $DHALL --bash-completion-script $DHALL > $out/etc/bash_completion.d/dhall-completion.bash
  '';
}
