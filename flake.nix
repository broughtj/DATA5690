{
  description = "Quarto book environment with Python, LaTeX, and scientific libraries";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        pythonPackages = pkgs.python310Packages;
      in
      {
        devShell = pkgs.mkShell {
          # System Packages
          buildInputs = [
            pkgs.python310           # Python 3.10
            pkgs.quarto              # Quarto for writing the book
            pkgs.texlive.combined.scheme-full  # Full LaTeX for rendering PDFs
            pkgs.git                 # Git for version control
            pkgs.direnv              # Direnv for environment management
          ];

          # Python packages installed with pip
          PIP_REQUIRE_VIRTUALENV = "true";
          shellHook = ''
            if [ ! -d .venv ]; then
              python3 -m venv .venv
            fi
            source .venv/bin/activate
            pip install numpy_financial pandas numpy scipy matplotlib jax pyyaml ipython jupyter
          '';
        };
      });
}