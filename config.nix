{
  config,
  pkgs,
  ...
}: {
  boot = {
    # Needed for Cilium gateways.
    kernelModules = [
      "iptable_filter"
      "iptable_mangle"
      "iptable_nat"
      "iptable_raw"
      "xt_socket"
    ];
    # Use the latest stable Linux kernel.
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages = with pkgs; [
      wl-clipboard
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];

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

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    firewall = {
      enable = true;
    };
    nameservers = ["1.1.1.1" "8.8.8.8"];
    networkmanager.dns = "systemd-resolved";
    useDHCP = true;
    wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enabled = true;
        Settings.AutoConnect = true;
      };
    };
  };

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

  programs = {
    hyprland.enable = true;
    nix-ld.enable = true;
  };

  # System services.
  services = {
    envfs.enable = true;
    fstrim.enable = true;
    pipewire = {
      alsa.enable = true;
      enable = true;
      pulse.enable = true;
    };
    resolved = {
      dnsovertls = "true";
      dnssec = "true";
      domains = ["~."];
      enable = true;
      fallbackDns = ["1.1.1.1" "8.8.8.8"];
    };
  };

  # Enable real-time scheduling for Pipewire and Sway.
  security.rtkit.enable = true;

  # Do not change!
  system.stateVersion = "23.11";

  time.timeZone = "Europe/Berlin";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jaro = {
    # Enable ‘sudo’ for the user.
    extraGroups = ["wheel" "docker"];
    isNormalUser = true;
  };

  virtualisation.docker = {
    enable = true;
  };
}
