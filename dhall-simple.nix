{ pkgs ? import <nixpkgs> {} }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-simple";
  binNames = [ "dhall" ];
  attrName = "dhall";
}
