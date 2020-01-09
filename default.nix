let

  pkgs = import <nixpkgs>{
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };

  program = import ./program.nix{inherit pkgs;};

  cuda= pkgs.dockerTools.pullImage {
    imageName = "nvidia/cuda";
    finalImageTag = "10.1-runtime-ubuntu18.04";
    finalImageName = "cuda";
    sha256 = "0wwr9vm5hg6jmhdgdn5vywp43yk7892xwbhrrycwvbkp0jcmawh9";
    imageDigest = "sha256:2a544a1f9e72fb4fb4cdaf8780d43a5319b749d04d8d32c7561c9f44937b628b";
  };


in pkgs.dockerTools.buildImage {
    name = "awesome";
    tag = "latest";

    fromImage = cuda;
    contents = [program pkgs.bash pkgs.coreutils pkgs.strace];

    config = {
      Env= [
      "CUDA_VERSION=10.0.130"
      "NVIDIA_VISIBLE_DEVICES=all"
      "CUDA_VERSION=10.1.243"
      "NVIDIA_DRIVER_CAPABILITIES=compute,utility"
      "NVIDIA_REQUIRE_CUDA=cuda>=10.1 brand=tesla,driver>=384,driver<385 brand=tesla,driver>=396,driver<397 brand=tesla,driver>=410,driver<411"
      "LD_PRELOAD=/usr/local/cuda-10.1/compat/libcuda.so.1 /usr/local/cuda-10.1/compat/libnvidia-fatbinaryloader.so.418.87.01 /usr/local/cuda-10.1/compat/libnvidia-ptxjitcompiler.so"
      "LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64"
      ];
    #  Env= ["CUDA_VERSION=10.0.130" "NVIDIA_VISIBLE_DEVICES=all"];
      Entrypoint = "/bin/main";
    #  Cmd = [ "--allow-root" "--ip=0.0.0.0" ];
    #  ExposedPorts = {"8888/tcp" = {};};
    };
}
