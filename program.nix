{
   pkgs ? null
}:

pkgs.stdenv.mkDerivation {
  name = "nix-cuda-docker-app";
  version = "0.0.1";
  src = ./.;

  nativeBuildInputs = with pkgs; [ ];
  buildInputs = with pkgs; [
     cudatoolkit_10
  ];

  buildPhase = ''nvcc -o main src/main.cu'';
  installPhase = ''mkdir -p $out/bin && cp main $out/bin'';
  dontFixup = true;
}