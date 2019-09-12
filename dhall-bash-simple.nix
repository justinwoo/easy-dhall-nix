{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-bash-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.0/dhall-bash-1.0.23-x86_64-macos.tar.bz2";
    sha256 = "1v941mad72xww4zyz4kr1d6czyl8834pbfrqpafnixj4brs6vzy5";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.0/dhall-bash-1.0.23-x86_64-linux.tar.bz2";
    sha256 = "1viq504bg5s9as984f93isakhzrb4nxg43s9y63jfhb17xf9rb3b";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_BASH=$out/bin/dhall-to-bash
    install -D -m555 -T dhall-to-bash $DHALL_TO_BASH

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_BASH --bash-completion-script $DHALL_TO_BASH > $out/etc/bash_completion.d/dhall-to-bash-completion.bash
  '';
}
