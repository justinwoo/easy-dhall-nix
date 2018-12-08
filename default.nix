{ pkgs ? import <nixpkgs> {} }:

let
  dhall-simple = import ./dhall-simple.nix {};
  dhall-json-simple = import ./dhall-json-simple.nix {};
  dhall-bash-simple = import ./dhall-bash-simple.nix {};
  dhall-text-simple = import ./dhall-text-simple.nix {};
in {
  inherit dhall-simple;

  shell = pkgs.stdenv.mkDerivation {
    name = "easy-dhall-nix-shell";

    buildInputs = [
      dhall-simple
      dhall-json-simple
      dhall-bash-simple
      dhall-text-simple
    ];
  };
}
