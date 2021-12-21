{ pkgs ? import ./nixpkgs.nix {} }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-csv-simple";
  binNames = [ "dhall-to-csv" "csv-to-dhall" ];
  attrName = "dhall-csv";
}
