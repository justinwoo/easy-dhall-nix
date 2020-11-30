import (fetchTarball {
  inherit (builtins.fromJSON (builtins.readFile ./nixpkgs.json))
    url
    sha256
    ;
})
