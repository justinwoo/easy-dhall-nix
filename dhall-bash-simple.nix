{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-bash-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.1/dhall-bash-1.0.23-x86_64-macos.tar.bz2";
    sha256 = "1gbz8li37vs2lnwdsf097kgij6d0z14fgwncdrs22915j44hiqrd";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.1/dhall-bash-1.0.23-x86_64-linux.tar.bz2";
    sha256 = "0ksycmd3b9h3i5q8y0a8yhpbpkzyrfazm7j2cx4ngdszlq586kna";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_BASH=$out/bin/dhall-to-bash
    install -D -m555 -T dhall-to-bash $DHALL_TO_BASH

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_BASH --bash-completion-script $DHALL_TO_BASH > $out/etc/bash_completion.d/dhall-to-bash-completion.bash
  '';
}
