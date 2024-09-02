{ pkgs }:

let
  server1 = pkgs.stdenv.mkDerivation {
    name = "server1";
    version = "1.0";

    buildInputs = [ pkgs.go ];

    src = ./server1;

    unpackPhase = "true";

    buildPhase = ''
      export GO111MODULE=off
      export GOCACHE=$(pwd)/.gocache
      mkdir -p $out/bin
      cd $src
      go build -o $out/bin/server1 server.go
    '';

    installPhase = ''
      echo "Binary built at $out/bin/server1"
    '';
  };

  server2 = pkgs.stdenv.mkDerivation {
    name = "server2";
    version = "1.0";

    buildInputs = [ pkgs.go ];

    src = ./server2;

    unpackPhase = "true";

    buildPhase = ''
      export GO111MODULE=off
      export GOCACHE=$(pwd)/.gocache
      mkdir -p $out/bin
      cd $src
      go build -o $out/bin/server2 server.go
    '';

    installPhase = ''
      echo "Binary built at $out/bin/server2"
    '';
  };

in
{
  inherit server1 server2;
}
