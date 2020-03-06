# Nvidia-Docker with nix

This Repository contains a minimal example to build a docker container which can be used with 
[nvidia-docker](https://github.com/NVIDIA/nvidia-docker).

A small test program (which is built using `program.nix`) is wrapped into a docker container (using the generic builder
in `buildCudaImage.nix`)

## Building

To build the containers you'll need to get the [nix build system](https://nixos.org/nix/). 
Afterwards call `nix-build` in the project dir.

## Running

As this project demonstrates how to build `nvidia-docker` container, you need to have it installed. Your local CUDA
Version should be at least 10.0.130.

When all requirements are satisfied you can run all containers using `./result/run-script.sh`