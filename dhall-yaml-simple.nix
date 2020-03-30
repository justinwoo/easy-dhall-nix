{ pkgs ? import <nixpkgs> {} }:

let
  release = import ./release.nix;
in

pkgs.stdenv.mkDerivation rec {
  name = "dhall-yaml-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = release.dhall-yaml-darwin.url;
    sha256 = release.dhall-yaml-darwin.hash;
  }
  else pkgs.fetchurl {
    url = release.dhall-yaml-linux.url;
    sha256 = release.dhall-yaml-linux.hash;
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_YAML=$out/bin/dhall-to-yaml-ng
    install -D -m555 -T dhall-to-yaml-ng $DHALL_TO_YAML

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_YAML --bash-completion-script $DHALL_TO_YAML > $out/etc/bash_completion.d/dhall-to-yaml-completion.bash
  '';
}
