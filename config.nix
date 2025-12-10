{ pkgs, ... }:
{
  boot = {
    # Emulate ARM and RISC-V binaries.
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "riscv64-linux"
    ];
    # Needed for Cilium gateways.
    kernelModules = [
      "iptable_filter"
      "iptable_mangle"
      "iptable_nat"
      "iptable_raw"
      "xt_socket"
    ];
    kernelPackages = pkgs.linuxPackages_testing;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages = with pkgs; [ wl-clipboard ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      options = [ "noatime" ];
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
    };
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
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
    enableAllFirmware = true;
    graphics.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    firewall.enable = true;
    useDHCP = false;
    wireless.iwd.enable = true;
  };

  nix = {
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
      secret-key-files = [ "/home/jaro/.ssh/nix_signing_key" ];
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "home-1:qFs3ojerUzQGzA3vYdbLXObqXd1h5FBk3xzHozmgBKI="
      ];
    };
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
    nix-ld.enable = true;
  };

  services = {
    envfs.enable = true;
    fstrim.enable = true;
    # Enable Yubikey smartcard mode.
    pcscd.enable = true;
    pipewire = {
      alsa.enable = true;
      enable = true;
      pulse.enable = true;
    };
    resolved = {
      dnsovertls = "true";
      dnssec = "true";
      domains = [ "~." ];
      enable = true;
      extraConfig = ''
        DNS=1.1.1.1 8.8.8.8
      '';
      fallbackDns = [ ];
    };
    udev.packages = [ pkgs.yubikey-personalization ];
  };

  security = {
    pam = {
      # Fix out of memory for flamegraph.
      loginLimits = [
        {
          domain = "*";
          type = "-";
          item = "memlock";
          value = "524288";
        }
        {
          domain = "*";
          type = "soft";
          item = "nofile";
          value = "8192";
        }
      ];
      # Login and sudo access with Yubikey.
      services = {
        login.u2fAuth = true;
        sudo.u2fAuth = true;
      };
    };
    # Enable real-time scheduling for Pipewire.
    rtkit.enable = true;
    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
  };

  # Do not change!
  system.stateVersion = "23.11";

  systemd.network = {
    enable = true;
    networks."10-network" = {
      dhcpV4Config.UseDNS = false;
      dhcpV6Config.UseDNS = false;
      ipv6AcceptRAConfig.UseDNS = false;
      linkConfig.RequiredForOnline = "no";
      matchConfig.Type = "ether wlan";
      networkConfig.DHCP = "yes";
    };
    wait-online.enable = false;
  };

  time.timeZone = "Europe/Berlin";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jaro = {
    extraGroups = [
      "docker"
      "tss"
      "wheel"
    ];
    isNormalUser = true;
  };

  virtualisation.docker = {
    enable = true;
  };
}
