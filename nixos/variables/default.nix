{ pkgs, ... }@inputs :
{
  environment.sessionVariables = {
    CC = ''
      gcc
    '';
  };
}
