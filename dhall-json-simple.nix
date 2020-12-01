{ pkgs ? import ./nixpkgs.nix {} }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-json-simple";
  binNames = [ "dhall-to-json" "dhall-to-yaml" "json-to-dhall" ];
  attrName = "dhall-json";
}
