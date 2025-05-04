{ pkgs, ... }@inputs :
{
  environment.variables = {
    LD_LIBRARY_PATH = ''
      ${pkgs.glibc.outPath}/lib:${pkgs.glibc.outPath}/lib64:${pkgs.zlib.outPath}/lib
    '';
  };
}
