{
  description = "A Nix-flake-based Python + Julia development environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs;
            [(julia.withPackages
              [
                "Plots"
                "Catalyst"
                "DifferentialEquations"
                "Latexify"
              ]
            )
            (pkgs.python3.withPackages (python-pkgs:
              [
                python-pkgs.pandas
                python-pkgs.numpy
              ]
            )
            
            ];
        };
          shellHook = ''
            venv="$(cd $(dirname $(which python)); cd ..; pwd)"
            ln -Tsf "$venv" .venv
          '';

      });
    };
}