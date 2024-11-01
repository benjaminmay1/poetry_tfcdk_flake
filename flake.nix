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
            pipenv
            docker
            poetry
            unzip  
          ];

          shellHook = ''
            echo "Terraform CDK Python environment with Poetry activated"
            if ! command -v cdktf &> /dev/null; then
              echo "Installing cdktf-cli..."
              npm install -g cdktf-cli
            fi
            echo "Run 'cdktf --help' to see available commands"
            echo "Run 'poetry --version' to check Poetry installation"
            echo ""
            echo "To initialize a new CDKTF project with Python and Poetry, run:"
            echo "cdktf init --template=\"https://github.com/johnfraney/cdktf-remote-template-python-poetry/archive/refs/heads/main.zip\" --local"
          '';
        };
      }
    );
}
