{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-bash-simple";

  src = if pkgs.stdenv.isDarwin
    then pkgs.fetchurl {
      url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.25.0/dhall-bash-1.0.22-x86_64-macos.tar.bz2";
      sha256 = "1dqahd3rnsi8rh14cxyn7xvzg9p9brjqmymy085a1iq2bykqydp1";
    }
    else pkgs.fetchurl {
      url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.25.0/dhall-bash-1.0.22-x86_64-linux.tar.bz2";
      sha256 = "1849qacj6xk3ki8hyw3862jrabq2gp44sjay0r9iiygifzm51pk6";
    };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_BASH=$out/bin/dhall-to-bash
    install -D -m555 -T dhall-to-bash $DHALL_TO_BASH

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_BASH --bash-completion-script $DHALL_TO_BASH > $out/etc/bash_completion.d/dhall-to-bash-completion.bash
  '';
}
