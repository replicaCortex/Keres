{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };
  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            (python3.withPackages (ps:
              with ps; [
                ipython
                ipykernel
                jupyter
                # numpy
                # pytest
                # matplotlib
                # scipy
                # # catboost
                # xgboost
                # pandas
                # pip
                # seaborn
                # scikit-learn
                # tqdm
              ]))
          ];
          shellHook = ''
            python -m ipykernel install --user --name python_NIX --display-name "kernel NIX"

            # exec zsh

            trap 'jupyter kernelspec uninstall python_nix -y' EXIT;

          '';
        };
      }
    );
}
