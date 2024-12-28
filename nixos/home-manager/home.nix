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
	material-nvim
        nvim-web-devicons
        neo-tree-nvim
        telescope-nvim
	plenary-nvim
	nui-nvim
	telescope-ui-select-nvim
        nvim-treesitter.withAllGrammars
        nvim-lspconfig
	none-ls-nvim
	lualine-nvim
	dashboard-nvim
	nvim-cmp
	cmp-nvim-lsp
	luasnip
	cmp_luasnip
	friendly-snippets
     ];

      extraPackages = with pkgs; [
        lua-language-server
        nodePackages.typescript-language-server
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
      window.opacity = 0.95;
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
          background = "#282433";
          foreground = "#eee9fc";
        };
	cursor = {
	  text 	 = "#eee9fc";
	  cursor = "#eee9fc";
	};
        normal = {
	  black   = "#282433";
    	  red     = "#e965a5";
    	  green   = "#b1f2a7";
    	  yellow  = "#ebde76";
    	  blue    = "#b1baf4";
    	  magenta = "#e192ef";
    	  cyan    = "#b3f4f3";
    	  white   = "#eee9fc";
        };
        bright = {
	  black   = "#3f3951";
    	  red     = "#e965a5";
    	  green   = "#b1f2a7";
    	  yellow  = "#ebde76";
    	  blue    = "#b1baf4";
    	  magenta = "#e192ef";
    	  cyan    = "#b3f4f3";
    	  white   = "#eee9fc";
        };
      };
    };
  };
}
