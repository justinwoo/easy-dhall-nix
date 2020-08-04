{ pkgs ? import <nixpkgs> {} }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-nix-simple";
  binName = "dhall-to-nix";
  attrName = "dhall-nix";
}
