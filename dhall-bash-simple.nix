{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-bash-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.28.0/dhall-bash-1.0.25-x86_64-macos.tar.bz2";
    sha256 = "1rvsq6ipy58x99iqs45y8ha751aalvq1g8idvgpq028mv7qq6b3w";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.28.0/dhall-bash-1.0.25-x86_64-linux.tar.bz2";
    sha256 = "0zl85ydad1cl1lngsg5i8gm7bnp7zs11bggfwlnypfr7kfj1zdyk";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_BASH=$out/bin/dhall-to-bash
    install -D -m555 -T dhall-to-bash $DHALL_TO_BASH

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_BASH --bash-completion-script $DHALL_TO_BASH > $out/etc/bash_completion.d/dhall-to-bash-completion.bash
  '';
}
