{
   pkgs,
   cudatoolkit ? pkgs.cudatoolkit_10
}:
let
  program = with pkgs;import ./program.nix{inherit stdenv cudatoolkit;};

in import ./buildCudaImage.nix {

  buildImage = pkgs.dockerTools.buildImage;
  cudatoolkit = cudatoolkit;

  name = "awesome";
  tag = "latest";

  contents = [program pkgs.bash pkgs.coreutils];
  config = {
    Entrypoint = "/bin/main";
  };
}
