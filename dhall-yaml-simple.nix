{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-yaml-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-yaml-1.0.1-x86_64-macos.tar.bz2";
    sha256 = "0rg1gsr6fhx71sadr8xcwik202jfbpwcvgj3bjzbvsx8hvn2cy13";
  }
  else pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.29.0/dhall-yaml-1.0.1-x86_64-linux.tar.bz2";
    sha256 = "13gnqq3xjilrs4zmp7c7jybyw9xa7ipi3kkrp7mr826vypcwlrga";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_YAML=$out/bin/dhall-to-yaml-ng
    install -D -m555 -T dhall-to-yaml-ng $DHALL_TO_YAML

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_YAML --bash-completion-script $DHALL_TO_YAML > $out/etc/bash_completion.d/dhall-to-yaml-completion.bash
  '';
}
