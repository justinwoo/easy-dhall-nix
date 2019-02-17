{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-bash-simple";
  version = "1.20.1";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/${version}/dhall-bash-${version}-x86_64-linux.tar.bz2";
    sha256 = "0vm45pj4iffrdrmf71cfgpim4gdx29r4ddawkhspirjg4hy28m2j";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_BASH=$out/bin/dhall-to-bash
    install -D -m555 -T dhall-to-bash $DHALL_TO_BASH

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_BASH --bash-completion-script $DHALL_TO_BASH > $out/etc/bash_completion.d/dhall-to-bash-completion.bash
  '';
}
