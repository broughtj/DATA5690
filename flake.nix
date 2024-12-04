{
  description = "A Nix flake for a Quarto book project with Python, numpy-financial, and Jupyter";

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
          ipykernel
          jupyter
          (
            ps.buildPythonPackage rec {
              pname = "numpy-financial";
              version = "1.0.0";
              src = pkgs.fetchPypi {
                inherit pname version;
                sha256 = "sha256-+ENBvGKySF1WBKc9X6x+kZdbS5zV9KWpz2CJAuoAy0A=";
              };
              doCheck = false;
              propagatedBuildInputs = [ numpy ];
            }
          )
        ]);

        setupKernelScript = pkgs.writeShellScriptBin "setup-jupyter-kernel" ''
          #!/bin/sh
          ${customPython}/bin/python -m ipykernel install --user --name nix-quarto-env --display-name "Python (Nix Quarto Env)"
          echo "Jupyter kernel 'Python (Nix Quarto Env)' has been created."
        '';
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            customPython
            pkgs.quarto
            pkgs.texlive.combined.scheme-full
            setupKernelScript
          ];

          shellHook = ''
            echo "Welcome to your Quarto book project environment!"
            echo "Python, Quarto, LaTeX, and Jupyter are available."
            echo "To set up the Jupyter kernel, run: setup-jupyter-kernel"
            echo "Python packages installed: numpy, pandas, numpy-financial, ipykernel, jupyter"
          '';
        };
      }
    );
}
