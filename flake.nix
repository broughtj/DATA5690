{
  description = "A Nix flake for a Quarto book project with Python and numpy-financial";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        
        customPython = pkgs.python3.withPackages (ps: with ps; [
          numpy
          pandas
          (
            ps.buildPythonPackage rec {
              pname = "numpy-financial";
              version = "1.0.0";
              src = pkgs.fetchPypi {
                inherit pname version;
                sha256 = "0hc97k7bbrxj3d2z78jzszx45jhb7k6s2j8wi9jg2lp1qx3bpj5c";
              };
              doCheck = false;
              propagatedBuildInputs = [ numpy ];
            }
          )
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            customPython
            pkgs.quarto
            pkgs.texlive.combined.scheme-full
          ];

          shellHook = ''
            echo "Welcome to your Quarto book project environment!"
            echo "Python, Quarto, and LaTeX are available."
            echo "Python packages installed: numpy, pandas, numpy-financial"
          '';
        };
      }
    );
}
