{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = (import nixpkgs) {
          inherit system;
        };

        nativeBuildInputs = with pkgs; [pkg-config];
        buildInputs = with pkgs; [systemd];
      in rec {
        devShell = pkgs.mkShell {
          nativeBuildInputs = nativeBuildInputs;
          buildInputs = buildInputs;

          packages = with pkgs; [
            # Code formatting tools
            treefmt
            alejandra
            rustfmt
            mdl

            # Deployment tools
            kapp
            kubernetes-helm

            # Secret management
            sops
            vals

            # Rust toolchain
            cargo
            rustc

            # Code analysis tools
            clippy
            rust-analyzer
          ];
        };
      }
    );
}
