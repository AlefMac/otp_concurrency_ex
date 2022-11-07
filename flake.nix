{
  description = "Development environment";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixpkgs-unstable"; };
    flake-utils = { url = "github:numtide/flake-utils"; };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        inherit (nixpkgs.lib) optional;
        pkgs = import nixpkgs { inherit system; };
        beamPkg = pkgs.beam.packagesWith pkgs.erlangR24;

        elixir = beamPkg.elixir.override {
          version = "1.12.3";
          sha256 = "Jo9ZC5cSBVpjVnGZ8tEIUKOhW9uvJM/h84+VcnrT0R0=";
        };

        elixir-ls = pkgs.beam.packages.erlang.elixir_ls;
        locales = pkgs.glibcLocales;
      in
      with pkgs;
      {
        devShell = pkgs.mkShell
          {
            buildInputs = [
              erlangR24
              elixir
              locales
            ];
          };
      }
    );
}