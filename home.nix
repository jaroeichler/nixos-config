{
  config,
  pkgs,
  ...
}: let
  background = "2D2A2E";
  foreground = "FCFCFA";

  black = "403E41";
  blue = "FC9867";
  cyan = "78DCE8";
  green = "A9DC76";
  grey = "727072";
  magenta = "AB9DF2";
  red = "FF6188";
  white = "FCFCFA";
  yellow = "FFD866";
in {
  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home = {
    packages = with pkgs; [
      dust
      google-chrome
      hyperfine
      ouch
      termusic
    ];
    pointerCursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      hyprcursor.enable = true;
    };
    stateVersion = "23.11";
  };

  programs = {
    bash = {
      enable = true;
      initExtra = ''
        export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(git_branch)\[\033[00m\] "
        git_branch() {
          git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
        }
      '';
      sessionVariables = {};
    };

    bat = {
      enable = true;
      config = {
        theme = "base16";
      };
    };

    bottom = {
      enable = true;
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
      hidden = true;
    };

    foot = {
      enable = true;
      server.enable = true;
      settings = {
        main = {
          dpi-aware = "yes";
          pad = "8x4";
        };
        colors = {
          inherit background;
          inherit foreground;
          regular0 = black;
          regular1 = red;
          regular2 = green;
          regular3 = yellow;
          regular4 = blue;
          regular5 = magenta;
          regular6 = cyan;
          regular7 = white;
          bright0 = grey;
          bright1 = red;
          bright2 = green;
          bright3 = yellow;
          bright4 = blue;
          bright5 = magenta;
          bright6 = cyan;
          bright7 = white;
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
          cancel = "Control+c";
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

    tealdeer = {
      enable = true;
      settings.updates.auto_update = true;
    };

    zathura = {
      enable = true;
      options = {
        completion-bg = "#" + background;
        completion-fg = "#" + foreground;
        completion-group-bg = "#" + background;
        completion-group-fg = "#" + foreground;
        completion-highlight-bg = "#" + background;
        completion-highlight-fg = "#" + foreground;
        default-bg = "#" + background;
        default-fg = "#" + foreground;
        font = "JetBrainsMono 13";
        highlight-active-color = "rgba(255, 97, 136, 0.4)";
        highlight-color = "rgba(255, 216, 102, 0.4)";
        index-active-bg = "#" + foreground;
        index-active-fg = "#" + background;
        index-bg = "#" + background;
        index-fg = "#" + foreground;
        inputbar-bg = "#" + background;
        inputbar-fg = "#" + foreground;
        notification-bg = "#" + background;
        notification-error-bg = "#" + background;
        notification-error-fg = "#" + red;
        notification-fg = "#" + foreground;
        notification-warning-bg = "#" + background;
        notification-warning-fg = "#" + yellow;
        recolor = "true";
        recolor-darkcolor = "#" + foreground;
        recolor-lightcolor = "#" + background;
        selection-clipboard = "clipboard";
        statusbar-bg = "#" + background;
        statusbar-fg = "#" + foreground;
      };
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
        "Mod1, Return, exec, foot"
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
    };
  };
}
