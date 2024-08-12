# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
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
      # Enable flakes.
      experimental-features = [
        "nix-command"
        "flakes"
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
    hack-font
    noto-fonts
    noto-fonts-cjk
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
