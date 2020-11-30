{ pkgs ? import ./nixpkgs.nix { } }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-docs-simple";
  binNames = [ "dhall-docs" ];
  attrName = "dhall-docs";
}
