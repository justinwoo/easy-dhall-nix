{ pkgs ? import ./nixpkgs.nix {} }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-yaml-simple";
  binNames = [ "dhall-to-yaml-ng" "yaml-to-dhall" ];
  attrName = "dhall-yaml";
}
