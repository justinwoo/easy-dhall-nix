{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-nix-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.1/dhall-nix-1.1.8-x86_64-macos.tar.bz2";
    sha256 = "0dgg5iljf8crx5vas8v5lz79h5kk4ss6vg1ngavs32vshzs9q9kc";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.26.1/dhall-nix-1.1.8-x86_64-linux.tar.bz2";
    sha256 = "1mqkk598xx4hbpq9az9biwzc4gwmxb98wjm2ss0agvpdr75w5xm4";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_NIX=$out/bin/dhall-to-nix
    install -D -m555 -T dhall-to-nix $DHALL_TO_NIX

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_NIX --bash-completion-script $DHALL_TO_NIX > $out/etc/bash_completion.d/dhall-to-nix-completion.bash
  '';
}
