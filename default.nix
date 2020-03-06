let

  pkgs = import <nixpkgs>{
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };

  my_docker = import ./test_image.nix{inherit pkgs;};

in my_docker