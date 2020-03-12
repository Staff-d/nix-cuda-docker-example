# Nvidia-Docker with nix

This Repository contains a minimal example to build a docker container which can be used with 
[nvidia-docker](https://github.com/NVIDIA/nvidia-docker). A more detailed look into how it works can be found on my 
[blog](https://sebastian-staffa.eu/posts/nvidia-docker-with-nix/).

A small test program (which is built using `program.nix`) is wrapped into a docker container (using the generic builder
in `buildCudaImage.nix`).

## Building

To build the containers you'll need to get the [nix build system](https://nixos.org/nix/). 
Afterwards call `nix-build` in the project dir. 

## Running

As this project demonstrates how to build `nvidia-docker` container, you need to have it installed. Your local CUDA
Version should be at least 10.0.130. If you require different version you can change the `toolkits` list in `default.nix`.

When all requirements are satisfied you can run all containers using `./result/run-script.sh`.

Example output:

```text
f9f30553cf96: Loading layer [==================================================>]  39.91MB/39.91MB
The image awesome-cuda-10.0.130:latest already exists, renaming the old one with ID sha256:7009448038a9fc1fdf80a3b467f3c4ddb502a32440f199cdf41f3a0dc5619e74 to empty string
Loaded image: awesome-cuda-10.0.130:latest
awesome-cuda-10.0.130
Runtime version 10000; Cuda error: 0 (no error)
Driver version 10010; Cuda error: 0 (no error)
Device count 1; Cuda error: 0 (no error)
1228318216db: Loading layer [==================================================>]  39.52MB/39.52MB
The image awesome-cuda-9.1.85.3:latest already exists, renaming the old one with ID sha256:c3006f9cc77298d438321d373ada218bf65dbd608509850bcebcaba2dbbcb737 to empty string
Loaded image: awesome-cuda-9.1.85.3:latest
awesome-cuda-9.1.85.3
Runtime version 9010; Cuda error: 0 (no error)
Driver version 10010; Cuda error: 0 (no error)
Device count 1; Cuda error: 0 (no error)
4c0fbc75e669: Loading layer [==================================================>]   39.8MB/39.8MB
The image awesome-cuda-9.2.148.1:latest already exists, renaming the old one with ID sha256:cafbd79f87cb7ac0e4bdad8d300f1c2499b1999f40ca1ea97e2f1fb8a1b72ffd to empty string
Loaded image: awesome-cuda-9.2.148.1:latest
awesome-cuda-9.2.148.1
Runtime version 9020; Cuda error: 0 (no error)
Driver version 10010; Cuda error: 0 (no error)
Device count 1; Cuda error: 0 (no error)

```