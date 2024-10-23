{
  config,
  pkgs,
  ...
}: {
  boot = {
    # Use the latest stable Linux kernel.
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  networking = {
    firewall = {
      enable = true;
    };
    useDHCP = true;
    wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enabled = true;
        Settings.AutoConnect = true;
      };
    };
  };

  # Localization settings.
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Berlin";

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Nix package manager configuration.
  nix = {
    # Automatic garbage collection.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Experimental = "true";
          FastConnectable = "true";
        };
      };
    };
    graphics.enable = true;
    xpadneo.enable = true;
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

  # System-wide program configuration.
  programs = {
    neovim = {
      defaultEditor = true;
      enable = true;
      viAlias = true;
    };
    nix-ld.enable = true;
  };

  # System-wide packages.
  environment.systemPackages = with pkgs; [
    fd
    ripgrep
    wl-clipboard
  ];

  # System services.
  services = {
    envfs.enable = true;
    fstrim.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };

  # Enable real-time scheduling for Pipewire and Sway.
  security.rtkit.enable = true;

  # Do NOT change this value.
  system.stateVersion = "23.11";
}
