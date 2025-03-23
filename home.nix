{
  config,
  pkgs,
  ...
}: let
  background = "#2D2A2E";
  foreground = "#FCFCFA";

  black = "#403E41";
  blue = "#FC9867";
  cyan = "#78DCE8";
  green = "#A9DC76";
  grey = "#727072";
  magenta = "#AB9DF2";
  red = "#FF6188";
  white = "#FCFCFA";
  yellow = "#FFD866";
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

    wezterm = {
      enable = true;
      enableBashIntegration = true;
      colorSchemes = {
        monokai-pro = {
          ansi = [
            black
            red
            green
            yellow
            blue
            magenta
            cyan
            white
          ];
          inherit background;
          brights = [
            grey
            red
            green
            yellow
            blue
            magenta
            cyan
            white
          ];
          cursor_bg = foreground;
          cursor_border = foreground;
          cursor_fg = background;
          inherit foreground;
          selection_bg = grey;
          selection_fg = white;
        };
      };
      extraConfig = ''
        return {
          animation_fps = 1,
          color_scheme = "monokai-pro",
          disable_default_key_bindings = true,
          font_size = 19,
          font = wezterm.font("JetBrains Mono"),
          hide_tab_bar_if_only_one_tab = true,
          keys = {
            {
              key = "Escape",
              mods = "ALT",
              action = wezterm.action.ActivateCopyMode
            },
            {
              key = "/",
              mods = "ALT",
              action = wezterm.action.Search {CaseSensitiveString=""}
            },
            {
              key = "p",
              mods = "ALT",
              action = wezterm.action.PasteFrom "Clipboard"
            },
            {
              key = "y",
              mods = "ALT",
              action = wezterm.action.CopyTo "Clipboard"
            },
          },
          window_close_confirmation = "NeverPrompt",
          window_decorations = "NONE",
          window_padding = {
            left = "0.5cell",
            right = "0.5cell",
            top = 0,
            bottom = 0,
          }
        }
      '';
    };

    zathura = {
      enable = true;
      options = {
        completion-bg = background;
        completion-fg = foreground;
        completion-group-bg = background;
        completion-group-fg = foreground;
        completion-highlight-bg = background;
        completion-highlight-fg = foreground;
        default-bg = background;
        default-fg = foreground;
        font = "JetBrainsMono 13";
        highlight-active-color = "rgba(255, 97, 136, 0.4)";
        highlight-color = "rgba(255, 216, 102, 0.4)";
        index-active-bg = foreground;
        index-active-fg = background;
        index-bg = background;
        index-fg = foreground;
        inputbar-bg = background;
        inputbar-fg = foreground;
        notification-bg = background;
        notification-error-bg = background;
        notification-error-fg = red;
        notification-fg = foreground;
        notification-warning-bg = background;
        notification-warning-fg = yellow;
        recolor = "true";
        recolor-darkcolor = foreground;
        recolor-lightcolor = background;
        selection-clipboard = "clipboard";
        statusbar-bg = background;
        statusbar-fg = foreground;
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
        "Mod1, Return, exec, wezterm"
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
