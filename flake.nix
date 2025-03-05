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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    git-hooks,
    home-manager,
    nixpkgs,
    ...
  }: let
    hooks = git-hooks.lib.${system}.run {
      hooks = import ./pre-commit-hooks.nix {inherit pkgs;};
      src = ./.;
    };
    pkgs = import nixpkgs {inherit system;};
    system = "x86_64-linux";

    config = id: {
      inherit system;
      modules = [
        ./config-${id}.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.jaro = import ./home-${id}.nix;
          };
        }
      ];
    };
  in {
    devShells.${system}.default = pkgs.mkShell {
      inherit (hooks) shellHook;
    };

    nixosConfigurations = {
      home = nixpkgs.lib.nixosSystem (config "home");
      thinkpad = nixpkgs.lib.nixosSystem (config "thinkpad");
    };
  };
}
