{ pkgs ? import <nixpkgs> {} }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-yaml-simple";
  binName = "dhall-to-yaml-ng";
  attrName = "dhall-yaml";
}
