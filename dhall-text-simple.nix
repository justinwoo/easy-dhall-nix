{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-text-simple";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.21.0/dhall-text-1.0.16-x86_64-linux.tar.bz2";
    sha256 = "0fisqhxy1s4f79rwp60avqdwqbklwj6sznfzx3pyaq6gn4p8wwnv";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_TEXT=$out/bin/dhall-to-text
    install -D -m555 -T dhall-to-text $DHALL_TO_TEXT

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_TEXT --bash-completion-script $DHALL_TO_TEXT > $out/etc/bash_completion.d/dhall-to-text-completion.bash
  '';
}
