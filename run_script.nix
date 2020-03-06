{
   pkgs
}:

pkgs.writeScript "nv-docker-run-script.sh" ''#!${pkgs.bash}/bin/bash

set -ue

DIRNAME=${pkgs.coreutils}/bin/dirname
READLINK=${pkgs.coreutils}/bin/readlink
GREP=${pkgs.gnugrep}/bin/grep

SCRIPTDIR=$($DIRNAME "$BASH_SOURCE")

for f in $SCRIPTDIR/*.tar.gz
do
    docker load -i $f
    CONTAINER=$(echo "$f" | $GREP -Poh "awesome-cuda-[0-9\.]+(?=\.tar\.gz)")
    echo $CONTAINER
    docker run --gpus all $CONTAINER:latest
done

''