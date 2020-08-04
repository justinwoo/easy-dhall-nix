{ pkgs ? import <nixpkgs> {} }:

let
  release = import ./release.nix;
in

pkgs.stdenv.mkDerivation rec {
  name = "dhall-json-simple";

  src = if pkgs.stdenv.isDarwin
  then pkgs.fetchzip {
    url = release.dhall-json-darwin.url;
    sha256 = release.dhall-json-darwin.hash;
    }
  else pkgs.fetchzip {
    url = release.dhall-json-linux.url;
    sha256 = release.dhall-json-linux.hash;
  };

  nativeBuildInputs = [ pkgs.installShellFiles ];

  installPhase = ''
    mkdir -p $out/bin
    DHALL_TO_JSON=$out/bin/dhall-to-json
    DHALL_TO_YAML=$out/bin/dhall-to-yaml
    JSON_TO_DHALL=$out/bin/json-to-dhall
    install -D -m555 -T dhall-to-json $DHALL_TO_JSON
    install -D -m555 -T dhall-to-yaml $DHALL_TO_YAML
    install -D -m555 -T json-to-dhall $JSON_TO_DHALL

    "$DHALL_TO_JSON" --bash-completion-script "$DHALL_TO_JSON" > "dhall-to-json.bash"
    "$DHALL_TO_YAML" --bash-completion-script "$DHALL_TO_YAML" > "dhall-to-yaml.bash"
    "$JSON_TO_DHALL" --bash-completion-script "$JSON_TO_DHALL" > "json-to-dhall.bash"
    installShellCompletion --bash "dhall-to-json.bash"
    installShellCompletion --bash "dhall-to-yaml.bash"
    installShellCompletion --bash "json-to-dhall.bash"
    "$DHALL_TO_JSON" --zsh-completion-script "$DHALL_TO_JSON" > "dhall-to-json.zsh"
    "$DHALL_TO_YAML" --zsh-completion-script "$DHALL_TO_YAML" > "dhall-to-yaml.zsh"
    "$JSON_TO_DHALL" --zsh-completion-script "$JSON_TO_DHALL" > "json-to-dhall.zsh"
    installShellCompletion --zsh "dhall-to-json.zsh"
    installShellCompletion --zsh "dhall-to-yaml.zsh"
    installShellCompletion --zsh "json-to-dhall.zsh"
    "$DHALL_TO_JSON" --fish-completion-script "$DHALL_TO_JSON" > "dhall-to-json.fish"
    "$DHALL_TO_YAML" --fish-completion-script "$DHALL_TO_YAML" > "dhall-to-yaml.fish"
    "$JSON_TO_DHALL" --fish-completion-script "$JSON_TO_DHALL" > "json-to-dhall.fish"
    installShellCompletion --fish "dhall-to-json.fish"
    installShellCompletion --fish "dhall-to-yaml.fish"
    installShellCompletion --fish "json-to-dhall.fish"
  '';
}
