{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-nix-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.27.0/dhall-nix-1.1.9-x86_64-macos.tar.bz2";
    sha256 = "0mhbcs9wbv1fdgzvqb71d8621kci6yqwhip1hbslhdxnm7z4p8rr";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.27.0/dhall-nix-1.1.9-x86_64-linux.tar.bz2";
    sha256 = "0n3fh7azr7avr8g73rg7csiacl1qgs9kf7j17q5a9bwwbqqid5k1";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_NIX=$out/bin/dhall-to-nix
    install -D -m555 -T dhall-to-nix $DHALL_TO_NIX

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_NIX --bash-completion-script $DHALL_TO_NIX > $out/etc/bash_completion.d/dhall-to-nix-completion.bash
  '';
}
