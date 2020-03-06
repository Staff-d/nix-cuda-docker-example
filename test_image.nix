{
   pkgs,
   base_image ? null
}:
let
  program = import ./program.nix{inherit pkgs;};

  dockerEntrypoint = pkgs.writeScript "entrypoint.sh" ''#!${pkgs.bash}/bin/bash
    printenv
    ${pkgs.strace}/bin/strace ${program}/bin/main
  '';

  dockerEntrypointDir = pkgs.linkFarm "entrypoint" [ { name ="entrypoint"; path=dockerEntrypoint;} ];

in pkgs.dockerTools.buildImage {
    name = "awesome";
    tag = "latest";

    #fromImage = cuda;
    contents = [dockerEntrypointDir pkgs.bash pkgs.coreutils];

    #runAsRoot= ''#!/bin/bash

    #mkdir -p /usr/local/nvidia/lib
    #mkdir -p /usr/local/nvidia/lib64

    #'';

    config = {
      Env= [  "CUDA_VERSION=10.0.130"
              "CUDA_PKG_VERSION=10-0=10.0.130-1"

              "NVIDIA_VISIBLE_DEVICES=all"
              "NVIDIA_DRIVER_CAPABILITIES=compute,utility"

              "NVIDIA_REQUIRE_CUDA=cuda>=10.1 brand=tesla,driver>=384,driver<385 brand=tesla,driver>=396,driver<397 brand=tesla,driver>=410,driver<411"
              "PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

              "SHLVL=1"
              "LIBRARY_PATH=/usr/local/cuda/lib64/stubs"
              #"LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64"
              "LD_LIBRARY_PATH=/usr/lib64/"
              #"LD_PRELOAD=/usr/local/cuda-10.1/compat/libcuda.so.1 /usr/local/cuda-10.1/compat/libnvidia-fatbinaryloader.so.418.87.01 /usr/local/cuda-10.1/compat/libnvidia-ptxjitcompiler.so /usr/local/cuda-10.1/targets/x86_64-linux/lib/stubs/libnvidia-ml.so"
              #"LD_PRELOAD=/usr/lib64/libcuda.so.1 /usr/lib64/libnvidia-fatbinaryloader.so.418.87.01 /usr/lib64/libnvidia-ptxjitcompiler.so"
              ];
      Entrypoint = "/entrypoint";

    };
}
