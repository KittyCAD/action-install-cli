{
  description = "Nix flake for building the action-install-cli Node GitHub Action";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      packages.${system}.install-zoo-cli = pkgs.stdenv.mkDerivation {
        pname = "install-zoo-cli";
        version = "1.0.0";
        src = self;
        buildInputs = [ pkgs.nodejs-20_x ];
        # Build phase: install npm dependencies and bundle with ncc.
        buildPhase = ''
          npm install
          npx @vercel/ncc build index.js -o dist
        '';
        installPhase = ''
          mkdir -p $out
          cp -r dist $out/
          cp action.yml $out/
          cp package.json $out/
        '';
        meta = with pkgs.lib; {
          description = "Install Zoo CLI Node GitHub Action, bundled with ncc using Node20";
          license = licenses.mit;
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [ pkgs.nodejs_20 ];
      };

      defaultPackage = self.packages.${system}.install-zoo-cli;
    };
}
