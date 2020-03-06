{
   pkgs,
   cudatoolkit ? pkgs.cudatoolkit_10
}:
let
  program = with pkgs;import ./program.nix{inherit stdenv cudatoolkit;};

  cuda_version_string = "CUDA_VERSION=" + cudatoolkit.version;

in pkgs.dockerTools.buildImage {
  name = "awesome";
  tag = "latest";

  contents = [program pkgs.bash pkgs.coreutils];
  config = {
    Env= [
      "${cuda_version_string}"
      "NVIDIA_VISIBLE_DEVICES=all"
      "NVIDIA_DRIVER_CAPABILITIES=all"

      "LD_LIBRARY_PATH=/usr/lib64/"
    ];
    Entrypoint = "/bin/main";

  };
}
