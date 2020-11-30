{ pkgs ? import ./nixpkgs.nix {} }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-nix-simple";
  binNames = [ "dhall-to-nix" ];
  attrName = "dhall-nix";
}
