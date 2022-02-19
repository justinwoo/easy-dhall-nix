{ pkgs ? import ./nixpkgs.nix { } }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-toml-simple";
  binNames = [ "dhall-to-toml" "toml-to-dhall" ];
  attrName = "dhall-toml";
}
