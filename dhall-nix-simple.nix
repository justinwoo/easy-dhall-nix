{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-nix-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.28.0/dhall-nix-1.1.10-x86_64-macos.tar.bz2";
    sha256 = "0izab5lh70bx0amfz36yqli06qcqw7hi18l4g15cfsqvm7pmqrfb";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.28.0/dhall-nix-1.1.10-x86_64-linux.tar.bz2";
    sha256 = "0k08jngf3sn0mnxcx2wkwg32ilx53zvw0m4608psc187sdslf03i";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_NIX=$out/bin/dhall-to-nix
    install -D -m555 -T dhall-to-nix $DHALL_TO_NIX

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_NIX --bash-completion-script $DHALL_TO_NIX > $out/etc/bash_completion.d/dhall-to-nix-completion.bash
  '';
}
