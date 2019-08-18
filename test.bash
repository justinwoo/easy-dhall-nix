#!/usr/bin/env nix-shell
#!nix-shell -i bash

ERRORS=0;

function test_exe () {
  EXE=$1;
  LOCATION=$(command -v "$EXE");
  if [ -x "$LOCATION" ]; then
    echo "found $EXE";
  else
    echo "didnt find $EXE";
    ERRORS=1;
  fi
}

test_exe dhall;
test_exe dhall-to-bash;

exit $ERRORS;
