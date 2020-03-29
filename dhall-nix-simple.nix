{ pkgs ? import <nixpkgs> {} }:

let
  release = import ./release.nix;
in

pkgs.stdenv.mkDerivation rec {
  name = "dhall-nix-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = release.dhall-nix-darwin.url;
    sha256 = release.dhall-nix-darwin.hash;
  }
  else pkgs.fetchurl {
    url = release.dhall-nix-linux.url;
    sha256 = release.dhall-nix-linux.hash;
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_NIX=$out/bin/dhall-to-nix
    install -D -m555 -T dhall-to-nix $DHALL_TO_NIX

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_NIX --bash-completion-script $DHALL_TO_NIX > $out/etc/bash_completion.d/dhall-to-nix-completion.bash
  '';
}
