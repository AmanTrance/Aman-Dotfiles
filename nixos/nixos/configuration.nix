{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver.enable = true;

  virtualisation.docker.enable = true;  
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };  

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;	
  
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager = {
    xfce.enable  = true;
  };

  services.xserver.xkb = {
    layout = "us";
  };

  services.printing.enable = true;
	
  hardware.graphics.enable = true;
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.amanfreecs = {
    isNormalUser = true;
    description = "amanfreecs"; 
    extraGroups = [ "networkmanager" "wheel" "kvm" "libvrtd" "docker" ];
  };

  nixpkgs.config = {
    allowUnfree = true;	
  };  
	
  environment.systemPackages = with pkgs; [ 
    wget
    go
    gopls
    rustup
    ruby
    ghc
    stack
    cabal-install
    python313
    kotlin
    libgccjit
    lua
    vscode
    git
    postman
    containerd
    redshift
    docker
    discord
    typescript
    gcc
    gnumake
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

  services.openssh.enable = true;
	
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];

  system.stateVersion = "24.11";
  
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
