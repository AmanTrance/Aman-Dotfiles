{ pkgs, ... }@inputs :
{
  imports = 
    [ 
      ./hardware
      ./system
      ./packages
      ./variables
    ];

  system.stateVersion = "24.11";
}
