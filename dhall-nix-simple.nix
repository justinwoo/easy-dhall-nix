{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-nix-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-nix-1.1.11-x86_64-macos.tar.bz2";
    sha256 = "0vrzsq09v1132sb2v7p4iidydbc64vrap6zlaa8v5j75gl98nbm7";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-nix-1.1.11-x86_64-linux.tar.bz2";
    sha256 = "0p5k3ij9cssywbsyhpyn7y2nz7fry0lmdi7j2dd516jm6kikbvh4";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_NIX=$out/bin/dhall-to-nix
    install -D -m555 -T dhall-to-nix $DHALL_TO_NIX

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_NIX --bash-completion-script $DHALL_TO_NIX > $out/etc/bash_completion.d/dhall-to-nix-completion.bash
  '';
}
