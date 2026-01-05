{ pkgs, ... }@inputs :
{
  environment.variables = with pkgs; {
    CC = ''
      ${gcc.outPath}/bin/gcc
    '';
  };
}
