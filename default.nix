{ pkgs ? import <nixpkgs> {} }:

{
  dhall-simple = import ./dhall-simple.nix {};
  dhall-json-simple = import ./dhall-json-simple.nix {};
  dhall-bash-simple = import ./dhall-bash-simple.nix {};
  dhall-text-simple = import ./dhall-text-simple.nix {};
}
