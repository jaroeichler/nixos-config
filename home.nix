{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      dust
      google-chrome
      hyperfine
      ouch
      termusic
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
    };

    bat = {
      enable = true;
      config.theme = "GitHub";
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
          background = "2D2A2E";
          foreground = "FCFCFA";
          regular0 = "403E41";
          regular1 = "FF6188";
          regular2 = "A9DC76";
          regular3 = "FFD866";
          regular4 = "FC9867";
          regular5 = "AB9DF2";
          regular6 = "78DCE8";
          regular7 = "FCFCFA";
          bright0 = "727072";
          bright1 = "FF6188";
          bright2 = "A9DC76";
          bright3 = "FFD866";
          bright4 = "FC9867";
          bright5 = "AB9DF2";
          bright6 = "78DCE8";
          bright7 = "FCFCFA";
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
          gutters = [];
          rulers = [81];
          bufferline = "multiple";
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
        completion-bg = "#fff8e1";
        completion-fg = "#21201d";
        completion-group-bg = "#fff8e1";
        completion-group-fg = "#21201d";
        completion-highlight-bg = "#fff8e1";
        completion-highlight-fg = "#21201d";
        default-bg = "#fff8e1";
        default-fg = "#21201d";
        font = "JetBrainsMono 13";
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

    zoxide = {
      enable = true;
    };
  };

  wayland.windowManager.sway = {
    config = {
      bars = [];
      defaultWorkspace = "workspace number 1";
      input = {
        "type:keyboard" = {
          xkb_options = "caps:escape";
        };
      };
      keybindings = {
        # Basics.
        "Mod1+q" = "kill";
        "Mod1+d" = "exec google-chrome-stable";
        "Mod1+Return" = "exec foot";
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
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
