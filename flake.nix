{
  description = "nixos-config";

  inputs = {
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    git-hooks = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:cachix/git-hooks.nix";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    flake-parts,
    git-hooks,
    home-manager,
    nixpkgs,
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
        hooks = git-hooks.lib.${system}.run {
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
        nixosConfigurations = {
          home = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./config-home.nix
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
          thinkpad = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./config-thinkpad.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.jaro = {
                    lib,
                    pkgs,
                    ...
                  }: {
                    imports = [./home.nix];
                    programs.foot.settings.main.font = lib.mkForce "Hack:size=11";
                    home.packages = with pkgs; [
                      acpi
                    ];
                  };
                };
              }
            ];
          };
          uni = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./config-uni.nix
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
    };
}
