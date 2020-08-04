{ pkgs ? import <nixpkgs> {} }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-bash-simple";
  binName = "dhall-to-bash";
  attrName = "dhall-bash";
}
