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
    gcc
    lua
    vscode
    git
    protobuf
    postman
    containerd
    redshift
    docker
    discord
    slack
    typescript
    gnumake
    nodejs_24
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
    sbt
    metals
    haskell-language-server
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
    nerd-fonts.hasklug
    nerd-fonts.symbols-only
  ];
}
