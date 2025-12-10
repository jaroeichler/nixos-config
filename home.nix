{ lib, pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk.enable = true;

  home = {
    packages = with pkgs; [
      bluetuith
      dust
      google-chrome
      hyperfine
      nautilus
      ouch
      python3
      tdf
      termusic
    ];
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
    };
    stateVersion = "23.11";
  };

  programs = {
    bash.enable = true;

    bat = {
      enable = true;
      config = {
        theme = "base16";
      };
    };

    bottom.enable = true;

    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
      };
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      git = true;
    };

    fd = {
      enable = true;
      extraOptions = [ "--hidden" ];
    };

    ghostty = {
      clearDefaultKeybinds = true;
      enable = true;
      settings = {
        confirm-close-surface = false;
        cursor-style = "block";
        cursor-style-blink = false;
        font-family = "JetBrains Mono";
        font-size = 19;
        keybind = [
          "alt+y=copy_to_clipboard"
          "alt+p=paste_from_clipboard"
          "alt+u=scroll_page_up"
          "alt+d=scroll_page_down"
          "alt+e=write_screen_file:paste"
        ];
        resize-overlay = "never";
        theme = "Monokai Pro";
        quick-terminal-animation-duration = 0;
        quit-after-last-window-closed = false;
        window-decoration = "none";
        window-inherit-working-directory = false;
      };
    };

    git = {
      enable = true;
      settings = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        init.defaultBranch = "main";
        user = {
          email = "88505041+jaroeichler@users.noreply.github.com";
          name = "jaroeichler";
          signingkey = "~/.ssh/id_ed25519_sk.pub";
        };
      };
    };

    helix = {
      defaultEditor = true;
      enable = true;
      languages = {
        language = [
          {
            auto-format = true;
            formatter.command = "nixfmt";
            language-servers = [ "nil" ];
            name = "nix";
          }
        ];
      };
      settings = {
        editor = {
          bufferline = "multiple";
          gutters = [ ];
          rulers = [ 81 ];
          soft-wrap.enable = true;
        };
        keys.normal = {
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
        };
        theme = "monokai_pro";
      };
    };

    mpv = {
      config = {
        deband = "yes";
        gpu-api = "opengl";
        hwdec = "auto";
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
      enable = true;
    };

    niri.settings = {
      animations.enable = false;
      binds = {
        "Alt+Backspace".action.close-window = [ ];
        "Alt+Semicolon".action.open-overview = [ ];
        "Alt+Delete".action.switch-preset-window-width = [ ];
        "Alt+Space".action.spawn = lib.getExe pkgs.google-chrome;
        "Alt+Return".action.spawn = lib.getExe pkgs.ghostty;
        # Focus and move
        "Alt+H".action.focus-column-left = [ ];
        "Alt+L".action.focus-column-right = [ ];
        "Alt+J".action.focus-workspace-down = [ ];
        "Alt+K".action.focus-workspace-up = [ ];
        "Alt+Shift+H".action.move-column-left = [ ];
        "Alt+Shift+L".action.move-column-right = [ ];
        "Alt+Shift+J".action.move-window-to-workspace-down = [ ];
        "Alt+Shift+K".action.move-window-to-workspace-up = [ ];
        # Volume
        "XF86AudioLowerVolume".action.spawn = [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.02-"
        ];
        "XF86AudioMute".action.spawn = [
          "wpctl"
          "set-mute"
          "@DEFAULT_AUDIO_SINK@"
          "toggle"
        ];
        "XF86AudioRaiseVolume".action.spawn = [
          "wpctl"
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.02+"
        ];
      };
      cursor.size = 36;
      gestures.hot-corners.enable = false;
      hotkey-overlay.skip-at-startup = true;
      input = {
        keyboard.xkb.options = "caps:escape";
        mouse.accel-profile = "flat";
      };
      layout = {
        background-color = "#2D2A2E";
        border.enable = false;
        default-column-width = {
          proportion = 1.0 / 3.0;
        };
        empty-workspace-above-first = true;
        focus-ring.enable = false;
        gaps = 0;
        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 1.0; }
        ];
      };
      outputs."DP-1".scale = 1;
      overview.backdrop-color = "#2D2A2E";
      prefer-no-csd = true;
      window-rules = [
        {
          clip-to-geometry = true;
          geometry-corner-radius = {
            top-left = 0.0;
            top-right = 0.0;
            bottom-left = 0.0;
            bottom-right = 0.0;
          };
        }
      ];
      xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite-unstable;
    };

    ripgrep = {
      arguments = [
        "--hidden"
        "--glob=!*bazel.lock"
        "--glob=!.git/*"
        "--smart-case"
      ];
      enable = true;
    };

    starship = {
      enable = true;
      settings = {
        add_newline = false;
        format = lib.concatStrings [
          "$username"
          "$hostname"
          "$directory"
          "$git_branch"
          "$git_state"
        ];
      };
    };

    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

    zoxide = {
      enable = true;
    };
  };
}
