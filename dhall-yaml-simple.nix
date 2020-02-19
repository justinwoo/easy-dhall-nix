{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-yaml-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-yaml-1.0.2-x86_64-macos.tar.bz2";
    sha256 = "05hj7h682bwk721r86qjq4s24q1vy302kacak9gn7l6k05awx166";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.30.0/dhall-yaml-1.0.2-x86_64-linux.tar.bz2";
    sha256 = "0n8015gc7pkqppqabxw66yvdv0kzd747z3hr477bzv1aawpc8i9f";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_YAML=$out/bin/dhall-to-yaml-ng
    install -D -m555 -T dhall-to-yaml-ng $DHALL_TO_YAML

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_YAML --bash-completion-script $DHALL_TO_YAML > $out/etc/bash_completion.d/dhall-to-yaml-completion.bash
  '';
}
