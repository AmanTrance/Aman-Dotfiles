{ pkgs, ... }@inputs : 
{

  home = {
    username = "amanfreecs";
    homeDirectory = "/home/amanfreecs";
    stateVersion = "24.11";
  };

  programs.tmux = {
    enable = true;
    terminal = "alacritty";
    extraConfig = ''
      set-option -ag terminal-features ",alacritty:RGB"
      set-option -sg escape-time 10
    '';
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
  };

  xdg.configFile.nvim = {
    source = ../config/nvim;
    recursive = true;
  };
	
  programs.bash = {	
    enable = true;

    shellAliases = {
      switchN = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      switchH = "home-manager switch --flake /etc/nixos#amanfreecs";
      switchU = "cd /etc/nixos && sudo nix flake update";
      vi = "nvim";
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.95;
      window.startup_mode = "Fullscreen";

      font = {
        size = 18.0;
        builtin_box_drawing = true;
        normal = {
          family = "JetBrainsMono Nerd Font";
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
