{ pkgs ? import <nixpkgs> {} }:

{
  dhall-simple = import ./dhall-simple.nix { inherit pkgs; };

  dhall-bash-simple = import ./dhall-bash-simple.nix { inherit pkgs; };
}
