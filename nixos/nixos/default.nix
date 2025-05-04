{ pkgs, ... }:

{
  imports = 
    [ 
      ./hardware
      ./system
      ./variables
      ./packages
    ];

  system.stateVersion = "24.11";
}
