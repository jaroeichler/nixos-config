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
    /etc/nixos/hardware-configuration.nix
    <home-manager/nixos>
  ];

  # Boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  # Networking.
  networking = {
    hostName = "home";
    wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enabled = true;
        Settings.AutoConnect = true;
      };
    };
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  # Sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  # Time zone and internationalisation.
  time.timeZone = "Europe/Berlin";
  # Allow unfree packages on system-level.
  nixpkgs.config.allowUnfree = true;
  # Enable flakes.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  hardware = {
    graphics.enable = true;
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
    xpadneo.enable = true;
  };
  # Packages.
  programs = {
    neovim = {
      defaultEditor = true;
      enable = true;
      viAlias = true;
    };
    nix-ld.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
  environment.systemPackages = with pkgs; [
    bat
    bottom
    delta
    fd
    ripgrep
    wl-clipboard
  ];
  # List services that you want to enable:
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jaro = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
  };
  # Home manager.
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.jaro = {
      home = {
        packages = with pkgs; [
          cmus
          google-chrome
          hack-font
          noto-fonts
        ];
        stateVersion = "23.11";
      };
      programs = {
        bash = {
          enable = true;
          initExtra = ''
            git_branch() {
              git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
            }
            export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(git_branch)\[\033[00m\] "
          '';
          sessionVariables = {};
          shellAliases = {
            top = "btm --color default-light";
            vi = "nvim";
          };
        };
        bat = {
          enable = true;
          config.theme = "GitHub";
        };
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        eza = {
          enable = true;
          git = true;
        };
        foot = {
          enable = true;
          settings = {
            main = {
              font = "Hack:size=13";
              dpi-aware = "yes";
              pad = "8x4";
            };
            colors = {
              alpha = "1.0";
              foreground = "21201d"; # black
              background = "fff8e1"; # amber
              regular0 = "21201d"; # black
              regular1 = "cd4340"; # red
              regular2 = "498d49"; # green
              regular3 = "fab32d"; # yellow
              regular4 = "3378c4"; # blue
              regular5 = "b83269"; # magenta
              regular6 = "21929a"; # cyan
              regular7 = "ffd7d7"; # white
              bright0 = "66635a"; # bright black
              bright1 = "dd7b72"; # bright red
              bright2 = "82ae78"; # bright green
              bright3 = "fbc870"; # bright yellow
              bright4 = "73a0cd"; # bright blue
              bright5 = "ce6f8e"; # bright magenta
              bright6 = "548c94"; # bright cyan
              bright7 = "ffe1da"; # bright white
              dim0 = "9e9a8c"; # dim black
              dim1 = "e9a99b"; # dim red
              dim2 = "b0c99f"; # dim green
              dim3 = "fdda9a"; # dim yellow
              dim4 = "a6c0d4"; # dim blue
              dim5 = "e0a1ad"; # dim magenta
              dim6 = "3c6064"; # dim cyan
              dim7 = "ffe9dd"; # dim white
            };
            key-bindings = {
              scrollback-up-page = "Control+b";
              scrollback-up-half-page = "Control+u";
              scrollback-up-line = "none";
              scrollback-down-page = "Control+f";
              scrollback-down-half-page = "Control+d";
              scrollback-down-line = "none";
              clipboard-copy = "Control+y XF86Copy";
              clipboard-paste = "Control+p XF86Paste";
              primary-paste = "none";
              search-start = "Control+slash";
              font-increase = "none";
              font-decrease = "none";
              font-reset = "none";
              spawn-terminal = "none";
              minimize = "none";
              maximize = "none";
              fullscreen = "none";
              show-urls-launch = "none";
              show-urls-copy = "none";
              show-urls-persistent = "none";
              noop = "none";
            };
            search-bindings = {
              cancel = "Control+c Escape";
              commit = "Return";
              find-prev = "Control+Shift+n";
              find-next = "Control+n";
              cursor-left = "none";
              cursor-left-word = "none";
              cursor-right = "none";
              cursor-right-word = "none";
              cursor-home = "none";
              cursor-end = "none";
              delete-prev = "none";
              delete-prev-word = "none";
              delete-next = "none";
              delete-next-word = "none";
              extend-to-word-boundary = "none";
              extend-to-next-whitespace = "none";
              clipboard-paste = "none";
              primary-paste = "none";
            };
            url-bindings = {
              cancel = "none";
              toggle-url-visible = "none";
            };
          };
        };
        git = {
          enable = true;
          extraConfig = {
            commit.gpgsign = true;
            gpg.format = "ssh";
            init.defaultBranch = "main";
            user.signingkey = "~/.ssh/id_ed25519.pub";
          };
          delta = {
            enable = true;
            options = {
              navigate = true;
              light = true;
              line-numbers = true;
            };
          };
          userEmail = "88505041+jaroeichler@users.noreply.github.com";
          userName = "jaroeichler";
        };
        mpv = {
          enable = true;
          config = {
            interpolation = "yes";
            profile = "gpu-hq";
            sub-border-size = 1;
            sub-font-size = 56;
            target-prim = "bt.709";
            target-trc = "srgb";
            tscale = "oversample";
            video-sync = "display-resample";
            vo = "gpu-next";
          };
        };
        neovim = {
          enable = true;
          extraConfig = ''
            autocmd FileType nix setlocal sw=2 ts=2
            autocmd FileType typst setlocal sw=2 ts=2
            filetype plugin indent on
            highlight colorcolumn ctermbg=white
            highlight visual ctermbg=white
            noremap <D-h> :bd<CR>
            noremap <D-j> :bp<CR>
            noremap <D-k> :bn<CR>
            noremap <D-l> :write<CR>
            noremap <D-\> 081l<S-f><Space>r<Enter>
            set clipboard=unnamedplus
            set colorcolumn=81
            set expandtab
            set notermguicolors
            set shiftwidth=4
            set tabstop=4
          '';
          extraLuaConfig = ''
            vim.filetype.add({
              extension = {
                typ = 'typst',
              },
            })
          '';
          plugins = with pkgs.vimPlugins; [
            {
              plugin = ale;
              config = ''
                highlight aleerror ctermbg=white
                highlight aleerrorline ctermbg=lightyellow
                highlight alewarning ctermbg=white
                highlight alewarningline ctermbg=lightyellow
                highlight aleinfo ctermbg=white
                highlight aleinfoline ctermbg=lightyellow
                let g:ale_set_signs=0
                let g:ale_linters = {
                \    'cpp': ['clangtidy'],
                \}
                let g:ale_fixers = {
                \    'cpp': ['clangtidy'],
                \    'nix': ['nixfmt', 'trim_whitespace'],
                \}
              '';
            }
            {
              plugin = nvim-treesitter.withAllGrammars;
              type = "lua";
              config = ''
                require'nvim-treesitter.configs'.setup {
                  highlight = {
                    additional_vim_regex_highlighting = false,
                    enable = true,
                    indent = {
                      enable = true
                    }
                  },
                }
              '';
            }
          ];
        };
        rtorrent.enable = true;
        zathura = {
          enable = true;
          options = {
            completion-bg = "#fff8e1";
            completion-fg = "#21201d";
            completion-group-bg = "#fff8e1";
            completion-group-fg = "#21201d";
            completion-highlight-bg = "#fff8e1";
            completion-highlight-fg = "#21201d";
            default-bg = "#fff8e1";
            default-fg = "#21201d";
            font = "hack 13";
            highlight-active-color = "#fab32d";
            highlight-color = "#fdda9a";
            index-active-bg = "#fff8e1";
            index-active-fg = "#21201d";
            index-bg = "#fff8e1";
            index-fg = "#21201d";
            inputbar-bg = "#fff8e1";
            inputbar-fg = "#21201d";
            notification-bg = "#fff8e1";
            notification-error-bg = "#fff8e1";
            notification-error-fg = "#cd4340";
            notification-fg = "#fab32d";
            notification-warning-bg = "#fff8e1";
            notification-warning-fg = "#cd4304";
            recolor = "true";
            recolor-darkcolor = "#21201d";
            recolor-lightcolor = "#fff8e1";
            selection-clipboard = "clipboard";
            statusbar-bg = "#fff8e1";
            statusbar-fg = "#21201d";
          };
        };
      };
      wayland.windowManager.sway = {
        enable = true;
        config = {
          bars = [];
          defaultWorkspace = "workspace number 1";
          floating.border = 0;
          keybindings = {
            # Basics.
            "Mod1+q" = "kill";
            "Mod1+d" = "exec google-chrome-stable";
            "Mod1+Return" = "exec foot";
            "Mod1+Shift+e" = "exec swaymsg exit";
            # Moving.
            "Mod1+j" = "focus left";
            "Mod1+k" = "focus right";
            "Mod1+Shift+j" = "move left";
            "Mod1+Shift+k" = "move right";
            # Volume.
            "XF86AudioLowerVolume" = "exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-";
            "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            "XF86AudioRaiseVolume" = "exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
            # Workspaces.
            "Mod1+1" = "workspace number 1";
            "Mod1+2" = "workspace number 2";
            "Mod1+3" = "workspace number 3";
            "Mod1+4" = "workspace number 4";
            "Mod1+5" = "workspace number 5";
            "Mod1+6" = "workspace number 6";
            "Mod1+7" = "workspace number 7";
            "Mod1+8" = "workspace number 8";
            "Mod1+9" = "workspace number 9";
            "Mod1+0" = "workspace number 10";
            "Mod1+Shift+1" = "move container to workspace number 1";
            "Mod1+Shift+2" = "move container to workspace number 2";
            "Mod1+Shift+3" = "move container to workspace number 3";
            "Mod1+Shift+4" = "move container to workspace number 4";
            "Mod1+Shift+5" = "move container to workspace number 5";
            "Mod1+Shift+6" = "move container to workspace number 6";
            "Mod1+Shift+7" = "move container to workspace number 7";
            "Mod1+Shift+8" = "move container to workspace number 8";
            "Mod1+Shift+9" = "move container to workspace number 9";
            "Mod1+Shift+0" = "move container to workspace number 10";
          };
          window = {
            border = 0;
            titlebar = false;
          };
        };
        wrapperFeatures.gtk = true;
      };
    };
  };

  # Do NOT change this value.
  system.stateVersion = "23.11";
}
