{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-text-simple";
  version = "1.20.1";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${version}/dhall-text-${version}-x86_64-linux.tar.bz2";
    sha256 = "1jly3v6sd2bymfa51c57kq6vzkvz1hr69gvlwpjpqimxvkk09hs8";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_TEXT=$out/bin/dhall-to-text
    install -D -m555 -T dhall-to-text $DHALL_TO_TEXT

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_TEXT --bash-completion-script $DHALL_TO_TEXT > $out/etc/bash_completion.d/dhall-to-text-completion.bash
  '';
}
