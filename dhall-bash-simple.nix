{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-bash-simple";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.23.0/dhall-bash-1.0.20-x86_64-linux.tar.bz2";
    sha256 = "0775d7ws2w5ra4l2vi1ml366w5p1hbbd151343mq0ycd06zgcnbr";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_BASH=$out/bin/dhall-to-bash
    install -D -m555 -T dhall-to-bash $DHALL_TO_BASH

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_BASH --bash-completion-script $DHALL_TO_BASH > $out/etc/bash_completion.d/dhall-to-bash-completion.bash
  '';
}
