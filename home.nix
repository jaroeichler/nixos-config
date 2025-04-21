{
  config,
  lib,
  pkgs,
  ...
}: {
  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk.enable = true;

  home = {
    packages = with pkgs; [
      dust
      google-chrome
      hyperfine
      ouch
      termusic
    ];
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      hyprcursor.enable = true;
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
      hidden = true;
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
          "super+y=copy_to_clipboard"
          "super+p=paste_from_clipboard"
          "super+u=scroll_page_up"
          "super+d=scroll_page_down"
          "super+e=write_screen_file:paste"
        ];
        resize-overlay = "never";
        theme = "Monokai Pro";
        quick-terminal-animation-duration = 0;
        quit-after-last-window-closed = false;
      };
    };

    git = {
      delta = {
        enable = true;
        options = {
          navigate = true;
          line-numbers = true;
        };
      };
      enable = true;
      extraConfig = {
        commit.gpgsign = true;
        gpg.format = "ssh";
        init.defaultBranch = "main";
        user.signingkey = "~/.ssh/id_ed25519.pub";
      };
      userEmail = "88505041+jaroeichler@users.noreply.github.com";
      userName = "jaroeichler";
    };

    helix = {
      defaultEditor = true;
      enable = true;
      settings = {
        editor = {
          bufferline = "multiple";
          gutters = [];
          rulers = [81];
          soft-wrap.enable = true;
        };
        keys.normal = {
          esc = ["collapse_selection" "keep_primary_selection"];
        };
        theme = "monokai_pro";
      };
    };

    mpv = {
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
      enable = true;
    };

    ripgrep = {
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

  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.variables = ["--all"];
    settings = {
      animations = {
        enabled = false;
      };
      bind = [
        # Basics
        "Mod1, q, killactive"
        "Mod1, d, exec, google-chrome-stable"
        "Mod1, Return, exec, ghostty"
        # Focus
        "Mod1, h, movefocus, l"
        "Mod1, j, movefocus, d"
        "Mod1, k, movefocus, u"
        "Mod1, l, movefocus, r"
        # Move window
        "Mod1 SHIFT, h, movewindow, l"
        "Mod1 SHIFT, j, movewindow, d"
        "Mod1 SHIFT, k, movewindow, u"
        "Mod1 SHIFT, l, movewindow, r"
        # Volume
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        # Workspaces
        "Mod1, 1, workspace, 1"
        "Mod1, 2, workspace, 2"
        "Mod1, 3, workspace, 3"
        "Mod1, 4, workspace, 4"
        "Mod1, 5, workspace, 5"
        "Mod1, 6, workspace, 6"
        "Mod1, 7, workspace, 7"
        "Mod1, 8, workspace, 8"
        "Mod1, 9, workspace, 9"
        "Mod1, 0, workspace, 10"
        "Mod1 SHIFT, 1, movetoworkspace, 1"
        "Mod1 SHIFT, 2, movetoworkspace, 2"
        "Mod1 SHIFT, 3, movetoworkspace, 3"
        "Mod1 SHIFT, 4, movetoworkspace, 4"
        "Mod1 SHIFT, 5, movetoworkspace, 5"
        "Mod1 SHIFT, 6, movetoworkspace, 6"
        "Mod1 SHIFT, 7, movetoworkspace, 7"
        "Mod1 SHIFT, 8, movetoworkspace, 8"
        "Mod1 SHIFT, 9, movetoworkspace, 9"
        "Mod1 SHIFT, 0, movetoworkspace, 10"
      ];
      decoration = {
        blur.enabled = false;
        shadow.enabled = false;
      };
      dwindle = {
        force_split = 2;
      };
      general = {
        border_size = 0;
        gaps_in = 0;
        gaps_out = 0;
        no_border_on_floating = true;
      };
      group = {
        auto_group = false;
      };
      input = {
        kb_options = "caps:escape";
      };
      misc = {
        background_color = "0x2D2A2E";
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = true;
      };
      monitor = [",preferred, auto, 1"];
    };
  };
}
