{
   stdenv,
   cudatoolkit
}:

stdenv.mkDerivation {
  name = "nix-cuda-docker-app";
  version = "0.0.1";
  src = ./.;

  buildInputs = [
     cudatoolkit
  ];

  buildPhase = ''nvcc -o main src/main.cu'';
  installPhase = ''mkdir -p $out/bin && cp main $out/bin'';
}