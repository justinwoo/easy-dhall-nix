{ pkgs ? import <nixpkgs> {} }:

let
  release = import ./release.nix;
in

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchzip {
    url = release.dhall-json-darwin.url;
    sha256 = release.dhall-json-darwin.hash;
    }
  else pkgs.fetchzip {
    url = release.dhall-json-linux.url;
    sha256 = release.dhall-json-linux.hash;
  };

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_JSON=$out/bin/dhall-to-json
    DHALL_TO_YAML=$out/bin/dhall-to-yaml
    JSON_TO_DHALL=$out/bin/json-to-dhall
    install -D -m555 -T dhall-to-json $DHALL_TO_JSON
    install -D -m555 -T dhall-to-yaml $DHALL_TO_YAML
    install -D -m555 -T json-to-dhall $JSON_TO_DHALL

    mkdir -p $out/etc/bash_completion.d/
    $DHALL_TO_JSON --bash-completion-script $DHALL_TO_JSON > $out/etc/bash_completion.d/dhall-to-json-completion.bash
    $DHALL_TO_YAML --bash-completion-script $DHALL_TO_YAML > $out/etc/bash_completion.d/dhall-to-yaml-completion.bash
    $JSON_TO_DHALL --bash-completion-script $JSON_TO_DHALL > $out/etc/bash_completion.d/json-to-dhall-completion.bash
  '';
}
