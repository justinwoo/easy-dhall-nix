{ pkgs ? import <nixpkgs> {} }:

let
  release = import ./release.nix;
in

pkgs.stdenv.mkDerivation rec {
  name = "dhall-bash-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchzip {
    url = release.dhall-bash-darwin.url;
    sha256 = release.dhall-bash-darwin.hash;
  }
  else pkgs.fetchzip {
    url = release.dhall-bash-linux.url;
    sha256 = release.dhall-bash-linux.hash;
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_BASH=$out/bin/dhall-to-bash
    install -D -m555 -T dhall-to-bash $DHALL_TO_BASH

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_BASH --bash-completion-script $DHALL_TO_BASH > $out/etc/bash_completion.d/dhall-to-bash-completion.bash
  '';
}
