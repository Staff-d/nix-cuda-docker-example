let

  pkgs = import <nixpkgs>{
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };

  program = import ./program.nix{inherit pkgs;};


in pkgs.dockerTools.buildImage {
    name = "awesome";
    tag = "latest";

    #fromImage = cuda;
    contents = [program pkgs.tree];

    config = {
    #  Env= ["LD_PRELOAD=/usr/local/cuda-10.1/compat/libcuda.so.1 /usr/local/cuda-10.1/compat/libnvidia-fatbinaryloader.so.418.87.00 /usr/local/cuda-10.1/compat/libnvidia-ptxjitcompiler.so /usr/lib/x86_64-linux-gnu/libnvidia-ml.so.418.87.00"];
      Entrypoint = "/bin/tree";
    #  Cmd = [ "--allow-root" "--ip=0.0.0.0" ];
    #  ExposedPorts = {"8888/tcp" = {};};
    };
}
