#!/usr/bin/env bash

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
test_exe dhall-to-json;
test_exe dhall-to-yaml;
test_exe dhall-to-bash;
test_exe dhall-to-text;

exit $ERRORS;
