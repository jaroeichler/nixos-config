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

    hooks = git-hooks.lib.${system}.run {
      hooks = import ./git-hooks.nix {inherit pkgs;};
      src = ./.;
    };

    pkgs = import nixpkgs {inherit system;};

    system = "x86_64-linux";
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
