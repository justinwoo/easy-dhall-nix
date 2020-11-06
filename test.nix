{ pkgs ? import <nixpkgs> {} }:

let

  lib = pkgs.lib;

  executables = lib.concatLists
    (lib.mapAttrsToList
      # every package puts its binNames into passthru
      (_: v: map (bin: "${v}/bin/${bin}") v.passthru.binNames)
      (import ./default.nix { inherit pkgs; }));

  testExeLocation = pkgs.writers.writeDash "test-exe-location" ''
    set -e
    ERRORS=0;

    test_exe () {
      EXE=$1;
      LOCATION=$(command -v "$EXE");
      if [ -x "$LOCATION" ]; then
        echo "found $EXE";
      else
        echo "didnt find $EXE";
        ERRORS=1;
      fi
    }

    for exe in ${lib.escapeShellArgs executables}; do
      test_exe "$exe"
    done

    exit "$ERRORS"

  '';

in {
  inherit
    testExeLocation;
}
