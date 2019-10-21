{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-bash-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.27.0/dhall-bash-1.0.24-x86_64-macos.tar.bz2";
    sha256 = "0xvdjfi54g70qyqzg10q845qnhwazrx042ixfny4v3zbyfhfdk3q";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.27.0/dhall-bash-1.0.24-x86_64-linux.tar.bz2";
    sha256 = "10l6wy3mh8m4hkdpwycwzg39hm69vv727jncd7hfb0q308xw0hr4";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_BASH=$out/bin/dhall-to-bash
    install -D -m555 -T dhall-to-bash $DHALL_TO_BASH

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_BASH --bash-completion-script $DHALL_TO_BASH > $out/etc/bash_completion.d/dhall-to-bash-completion.bash
  '';
}
