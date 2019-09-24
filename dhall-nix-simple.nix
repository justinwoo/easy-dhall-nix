{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-nix-simple";

  src = if pkgs.stdenv.isDarwin
  then throw "dhall nix only released for linux"
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.0/dhall-nix-1.1.8-x86_64-linux.tar.bz2";
    sha256 = "0zb1fl5bzaqfjg95m4znw3dcjkndl0nk6c70qd9pbrb4d2xch6s8";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_NIX=$out/bin/dhall-to-nix
    install -D -m555 -T dhall-to-nix $DHALL_TO_NIX

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_NIX --bash-completion-script $DHALL_TO_NIX > $out/etc/bash_completion.d/dhall-to-nix-completion.bash
  '';
}
