{ pkgs, ... }: {

  home = {
    username = "amanfreecs";
    homeDirectory = "/home/amanfreecs";
    stateVersion = "24.11";
  };

  programs.tmux = {
	enable = true;
  };

  programs.neovim = {
      enable = true;

      plugins = with pkgs.vimPlugins; [
        nvim-web-devicons
        nvim-tree-lua
        telescope-nvim
	telescope-ui-select-nvim
        nvim-treesitter.withAllGrammars
        nvim-lspconfig
	mason-nvim
	lualine-nvim
	material-nvim
     ];

      extraPackages = with pkgs; [
        haskellPackages.haskell-language-server
        lua-language-server
        nil
        nixpkgs-fmt
        statix
        pyright
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted
        ripgrep
        fd
      ];

      extraConfig = ''
        :luafile ~/.config/nvim/lua/init.lua
      '';
    };

    xdg.configFile.nvim = {
      source = ../config/nvim;
      recursive = true;
    };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 1.0;
      window.startup_mode = "Fullscreen";

      font = {
        size = 13.0;
        builtin_box_drawing = true;
        normal = {
          family = "JetBrains Mono";
          style = "Bold";
        };
      };

      colors = {
        primary = {
          background = "#282828";
          foreground = "#ebdbb2";
        };
        normal = {
          black   = "#282828";
          red     = "#cc241d";
          green   = "#98971a";
          yellow  = "#d79921";
          blue    = "#458588";
          magenta = "#b16286";
          cyan    = "#689d6a";
          white   = "#a89984";
        };
        bright = {
          black   = "#928374";
          red     = "#fb4934";
          green   = "#b8bb26";
          yellow  = "#fabd2f";
          blue    = "#83a598";
          magenta = "#d3869b";
          cyan    = "#8ec07c";
          white   = "#ebdbb2";
        };
      };
    };
  };
}
