{
    # see https://github.com/NixOS/nixpkgs/blob/0a351c3f65136c00d3512dd77f48e12a571cf495/pkgs/build-support/docker/default.nix#L656
    cudatoolkit,
    buildImage,
    lib,
    name,
    tag ? null,
    fromImage ? null,
    fromImageName ? null,
    fromImageTag ? null,
    contents ? null,
    keepContentsDirlinks ? false,
    config ? {Env = [];},
    extraCommands ? "",
    uid ? 0,
    gid ? 0,
    runAsRoot ? null,
    diskSize ? 1024,
    created ? "1970-01-01T00:00:01Z"
}:

let

  # cut the patch version from the version string
  cutVersion = with lib; versionString:
    builtins.concatStringsSep "."
      (take 3 (builtins.splitVersion versionString )
    );

  cudaVersionString = "CUDA_VERSION=" + (cutVersion cudatoolkit.version);

  cudaEnv = [
    "${cudaVersionString}"
    "NVIDIA_VISIBLE_DEVICES=all"
    "NVIDIA_DRIVER_CAPABILITIES=all"

    "LD_LIBRARY_PATH=/usr/lib64/"
  ];

  cudaConfig = config // {Env = cudaEnv;};

in buildImage {
  inherit name tag fromImage
    fromImageName fromImageTag contents
    keepContentsDirlinks extraCommands
    runAsRoot diskSize created;

  config = cudaConfig;
}
