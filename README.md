# Easy Dhall Nix

Derivations for easily downloading Dhall binaries and putting them to use.

## Trial

You can get an appropriate nix-shell with the binaries installed by first testing this with:

```shell-session
> nix-shell
```

## Installation

You might choose to simply copy the derivations from this repository, or you can fetch the git/GitHub repo using the various helpers:

```shell-session
> nix repl
nix-repl> pkgs = import ./nixpkgs.nix {}

nix-repl> drvs = import (pkgs.fetchFromGitHub {
  owner = "justinwoo";
  repo = "easy-dhall-nix";
  rev = # some REV
  sha256 = # some SHA
}) { inherit pkgs; }

nix-repl> drvs.dhall-simple
«derivation /nix/store/qz29jbplpmlvsbmq05084dh1fbs8sl0h-dhall-simple.drv»
```

## NixOS: Contributors needed

The derivations here have been tested by others to work on NixOS. If you have problems, open an issue.

## Update this repository

To update, run

```shell-session
> ./fetch.py
```

from the root of this repository.
It will prefetch the binaries from the latest dhall release on Github.
