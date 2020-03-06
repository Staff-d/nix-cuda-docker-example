let

  pkgs = import <nixpkgs>{
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };

  cuda = pkgs.dockerTools.pullImage {
    imageName = "nvidia/cuda";
    finalImageTag = "10.1-runtime-ubuntu18.04";
    finalImageName = "cuda";
    sha256 = "0wwr9vm5hg6jmhdgdn5vywp43yk7892xwbhrrycwvbkp0jcmawh9";
    imageDigest = "sha256:2a544a1f9e72fb4fb4cdaf8780d43a5319b749d04d8d32c7561c9f44937b628b";
  };

  my_docker = import ./test_image.nix{inherit pkgs; base_image = cuda;};

in my_docker