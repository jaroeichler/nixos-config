{
  description = "nixos-config";

  inputs = {
    git-hooks = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:cachix/git-hooks.nix";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    niri = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:sodiboo/niri-flake";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      git-hooks,
      home-manager,
      niri,
      nixpkgs,
      ...
    }:
    let
      config = id: {
        inherit system pkgs;
        modules = [
          ./config-${id}.nix
          home-manager.nixosModules.home-manager
          niri.nixosModules.niri
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.jaro = import ./home.nix;
            };
          }
        ];
      };

      hooks = git-hooks.lib.${system}.run {
        hooks = import ./git-hooks.nix { inherit pkgs; };
        src = ./.;
      };

      pkgs = import nixpkgs {
        config.allowUnfree = true;
        overlays = [ niri.overlays.niri ];
        inherit system;
      };

      system = "x86_64-linux";
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        inherit (hooks) shellHook;
        packages = with pkgs; [
          nil
          nixfmt
        ];
      };

      nixosConfigurations = {
        home = nixpkgs.lib.nixosSystem (config "home");
        thinkpad = nixpkgs.lib.nixosSystem (config "thinkpad");
      };
    };
}
