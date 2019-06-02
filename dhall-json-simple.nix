{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";

  src = pkgs.fetchurl {
    url = "https://github.com/dhall-lang/dhall-haskell/releases/download/1.23.0/dhall-json-1.2.8-x86_64-linux.tar.bz2";
    sha256 = "0fza35f9w9xvhxh5wnx5pkpb1mr0qxd7raqcslszl50vca0vl76v";
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_JSON=$out/bin/dhall-to-json
    DHALL_TO_YAML=$out/bin/dhall-to-yaml
    install -D -m555 -T dhall-to-json $DHALL_TO_JSON
    install -D -m555 -T dhall-to-yaml $DHALL_TO_YAML

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_JSON --bash-completion-script $DHALL_TO_JSON > $out/etc/bash_completion.d/dhall-to-json-completion.bash
    $DHALL_TO_YAML --bash-completion-script $DHALL_TO_YAML > $out/etc/bash_completion.d/dhall-to-yaml-completion.bash
  '';
}
