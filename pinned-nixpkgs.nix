{
    config ? {}
}:

let
  spec =
  {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "6b6f9d769a5086df38a06b680104d0c5fd1a8e0e";
    sha256 = "1pc6ypxas76i2l2dhr58bml2f0hmgz8py0d8zylwivhs6zg9fcgs";

  };
  url = "https://github.com/${spec.owner}/${spec.repo}/archive/${spec.rev}.tar.gz";

  nixpkgsSrc = builtins.fetchTarball {url = url; sha256 = spec.sha256;};
  pkgs = import nixpkgsSrc{ inherit config;};

in pkgs
