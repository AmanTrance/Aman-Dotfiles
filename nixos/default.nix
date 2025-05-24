{ pkgs, ... }:

{
  imports = 
    [ 
      ./hardware
      ./system
      ./packages
    ];

  system.stateVersion = "24.11";
}
