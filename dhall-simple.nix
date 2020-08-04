{ pkgs ? import <nixpkgs> {} }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-simple";
  binName = "dhall";
  attrName = "dhall";
}
