{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-text-simple";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.23.0/dhall-text-1.0.17-x86_64-linux.tar.bz2";
    sha256 = "1k9q01aswpdxfn868p9ljby32pmaxljmn80xpaana37rwvbghhml";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_TEXT=$out/bin/dhall-to-text
    install -D -m555 -T dhall-to-text $DHALL_TO_TEXT

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_TEXT --bash-completion-script $DHALL_TO_TEXT > $out/etc/bash_completion.d/dhall-to-text-completion.bash
  '';
}
