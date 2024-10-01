{
  description = "A Nix flake for a Quarto book project with Python";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        python-with-packages = pkgs.python3.withPackages (ps: with ps; [
	  jax 
	  jupyter
          numpy
          pandas
	  scipy
        ]);
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            python-with-packages
            pkgs.quarto
            pkgs.texlive.combined.scheme-full
          ];

          shellHook = ''
            echo "Welcome to your Quarto book project environment!"
            echo "Python, Quarto, and LaTeX are available."
            echo "Python packages installed: numpy, pandas"
          '';
        };
      }
    );
}
