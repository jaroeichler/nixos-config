# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Boot configuration.
  boot = {
    # Use the latest stable Linux kernel.
    kernelPackages = pkgs.linuxPackages_latest;
    # Configure bootloader.
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  # Network configuration.
  networking = {
    # Firewall settings.
    firewall = {
      # Open ports in the firewall if needed.
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
      enable = true;
    };
    hostName = "home";
    # Configure wireless networking.
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

  # Hardware configuration.
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

  # Font configuration.
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
    # # Enable Steam.
    # steam = {
    #   enable = true;
    #   remotePlay.openFirewall = true;
    #   dedicatedServer.openFirewall = true;
    # };
  };

  # System-wide packages.
  environment.systemPackages = with pkgs; [
    fd
    ripgrep
    wl-clipboard
  ];

  # System services.
  services = {
    # # Detect printers.
    # avahi = {
    #   enable = true;
    #   nssmdns4 = true;
    #   openFirewall = true;
    # };
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    # # Printing.
    # printing.enable = true;
  };

  # Enable real-time scheduling for Pipewire and Sway.
  security.rtkit.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jaro = {
    # Enable ‘sudo’ for the user.
    extraGroups = ["wheel"];
    isNormalUser = true;
  };

  # Do NOT change this value.
  system.stateVersion = "23.11";
}
