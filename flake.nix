{
  description = "Terraform CDK Python environment with Poetry";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            terraform
            nodejs
            python3
            python3Packages.pip
            python3Packages.virtualenv
            nodePackages.cdktf-cli
            docker
            poetry
            unzip
            azure-cli
          ];

          shellHook = ''
            echo "Terraform CDK Python environment with Poetry activated"
            echo "Run 'cdktf --help' to see available commands"
            echo "Run 'poetry --version' to check Poetry installation"
            echo "Run 'az --version' to check Azure CLI installation"
            echo ""
            echo "To initialize a new CDKTF project with Python and Poetry, run:"
            echo "cdktf init --template=\"https://github.com/johnfraney/cdktf-remote-template-python-poetry/archive/refs/heads/main.zip\" --local"
            echo ""
            echo "For WSL users: Remember to set up the Azure credentials symlink as described in the README.md"
          '';
        };
      }
    );
}
