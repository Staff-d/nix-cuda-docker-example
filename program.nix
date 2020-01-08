{
   pkgs
}:

pkgs.stdenv.mkDerivation {
  name = "cuda-saxpy";
  src = ./.;

  nativeBuildInputs = with pkgs; [  ];
  buildInputs = with pkgs; [
     cudatoolkit_10
  ];

  #builder="nvcc";
  buildPhase = ''nvcc -o main src/main.cu'';
  installPhase = ''mkdir -p $out/bin && cp main $out/bin'';

}