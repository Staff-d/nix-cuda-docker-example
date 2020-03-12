let

  pkgs = import ./pinned-nixpkgs.nix {
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };

  toolkits = with pkgs; [
    # These toolkits do not compile as of today (2020-03-09)
    # cudatoolkit_6 cudatoolkit_6_5
    # cudatoolkit_7 cudatoolkit_7_5
    # cudatoolkit_8
    cudatoolkit_9 cudatoolkit_9_1
    cudatoolkit_10_0
  ];

  container = with pkgs.lib; map (x:  import ./testImage.nix{inherit pkgs; cudatoolkit = x;}) toolkits;
  runScript = import ./runScript.nix {inherit pkgs;};

  dir = builtins.concatLists [
    (with pkgs.lib; map (x: {name = x.name; path = x;}) container) [ {name = "run-script.sh"; path = runScript;} ] ];

in pkgs.linkFarm "cuda-docker-container" dir