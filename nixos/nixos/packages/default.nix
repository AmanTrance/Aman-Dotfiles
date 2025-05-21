{ pkgs, ... }@inputs :
{
  environment.systemPackages = with pkgs; [
    file
    wget
    go
    gopls
    rustup 
    ruby
    ghc
    stack
    cabal-install
    python314
    kotlin
    libgcc
    libgccjit
    zlib
    lua
    vscode
    git
    postman
    containerd
    redshift
    docker
    discord
    typescript
    gnumake
    nodejs_23
    home-manager
    ocaml
    ocamlPackages.ocaml-lsp
    ripgrep
    dune_3
    opam
    brave
    erlang
    rebar3
    sbcl
  ];

  programs.bash = {	
    interactiveShellInit = ''
      eval $(${pkgs.opam}/bin/opam env)	
    '';
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts
    noto-fonts-emoji
    twemoji-color-font
    font-awesome
    powerline-fonts
    powerline-symbols
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
  ];
}
