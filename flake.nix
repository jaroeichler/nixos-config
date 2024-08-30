{
  description = "nixos-config";

  inputs = {
    git-hooks = {
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
      url = "github:cachix/git-hooks.nix";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    nixos-generators = {
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixlib.follows = "nixpkgs";
      url = "github:nix-community/nixos-generators";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    git-hooks,
    home-manager,
    nixos-generators,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    hooks = git-hooks.lib.${system}.run {
      hooks = import ./pre-commit-hooks.nix {inherit pkgs;};
      src = ./.;
    };

    config-home = {
      inherit system;
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

    config-thinkpad = {
      inherit system;
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

    config-uni = {
      inherit system;
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
  in {
    checks.${system} = {
      pre-commit-check = hooks;
    };

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [];
      shellHook = hooks.shellHook + '''';
    };

    packages.${system} = {
      home = nixos-generators.nixosGenerate (
        config-home
        // {format = "iso";}
      );
      thinkpad = nixos-generators.nixosGenerate (
        config-thinkpad
        // {format = "iso";}
      );
      uni = nixos-generators.nixosGenerate (
        config-uni
        // {format = "iso";}
      );
    };

    nixosConfigurations = {
      home = nixpkgs.lib.nixosSystem config-home;
      thinkpad = nixpkgs.lib.nixosSystem config-thinkpad;
      uni = nixpkgs.lib.nixosSystem config-uni;
    };
  };
}
