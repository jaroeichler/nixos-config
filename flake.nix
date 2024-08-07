{
  description = "nixos-config";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    pre-commit-hooks = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:cachix/git-hooks.nix";
    };
  };

  outputs = inputs @ {
    flake-parts,
    home-manager,
    nixpkgs,
    pre-commit-hooks,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      perSystem = {
        pkgs,
        system,
        ...
      }: let
        hooks = pre-commit-hooks.lib.${system}.run {
          hooks = import ./pre-commit-hooks.nix {inherit pkgs;};
          src = ./.;
        };
      in {
        checks = {
          pre-commit-check = hooks;
        };
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [];
          shellHook =
            hooks.shellHook
            + '''';
        };
      };
      flake = {
        nixosConfigurations.home = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.jaro = import ./home.nix;
              };
            }
          ];
        };
      };
    };
}
