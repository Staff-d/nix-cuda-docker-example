let

  pkgs = import <nixpkgs>{
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };

  program = import ./program.nix{inherit pkgs;};

  dockerEntrypoint = pkgs.writeScript "entrypoint.sh" ''#!${pkgs.bash}/bin/bash
    ${pkgs.strace}/bin/strace ${program}/bin/main
  '';

  dockerEntrypointDir = pkgs.linkFarm "entrypoint" [ { name ="entrypoint"; path=dockerEntrypoint;} ];

in pkgs.dockerTools.buildImage {
    name = "awesome";
    tag = "latest";

    #fromImage = cuda;
    contents = [dockerEntrypointDir pkgs.bash pkgs.coreutils];

    runAsRoot= ''#!/bin/bash

    mkdir -p /usr/local/nvidia/lib
    mkdir -p /usr/local/nvidia/lib64

    '';

    config = {
      Env= [ "CUDA_VERSION=10.0.130" 
             "NVIDIA_VISIBLE_DEVICES=all"
              "NVIDIA_DRIVER_CAPABILITIES=compute,utility"
              "LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64"
              "NVIDIA_REQUIRE_CUDA=cuda>=10.1 brand=tesla,driver>=384,driver<385 brand=tesla,driver>=396,driver<397 brand=tesla,driver>=410,driver<411"];
      Entrypoint = "/entrypoint";
      
    };
}
