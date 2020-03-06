{
   pkgs,
   cudatoolkit ? pkgs.cudatoolkit_10
}:
let
  program = with pkgs;import ./program.nix{inherit stdenv cudatoolkit;};

in import ./buildCudaImage.nix {

  inherit cudatoolkit;

  buildImage = pkgs.dockerTools.buildImage;
  lib = pkgs.lib;

  name = "awesome-cuda-"+cudatoolkit.version;
  tag = "latest";

  contents = [program];
  config = {
    Entrypoint = "/bin/main";
  };
}
