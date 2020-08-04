{ pkgs ? import <nixpkgs> {} }:

import ./build.nix { inherit pkgs; release = import ./release.nix; } {
  simpleName = "dhall-lsp-simple";
  binName = "dhall-lsp-server";
  attrName = "dhall-lsp-server";
}
