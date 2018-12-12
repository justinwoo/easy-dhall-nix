{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-bash-simple";
  version = "1.0.17";
  dhall-version = "1.19.1";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${dhall-version}/dhall-bash-${version}-x86_64-linux.tar.bz2";
    sha256 = "1y3rglsdmcbiarwfp907hxdd8swvdsh2874m9m4622ws4avz4v95";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_BASH=$out/bin/dhall-to-bash
    install -D -m555 -T dhall-to-bash $DHALL_TO_BASH

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_BASH --bash-completion-script $DHALL_TO_BASH > $out/etc/bash_completion.d/dhall-to-bash-completion.bash
  '';
}
