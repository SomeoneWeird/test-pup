{ pkgs }:

let
  server1 = pkgs.stdenv.mkDerivation {
    name = "server1";
    version = "1.0";

    buildInputs = [ pkgs.socat ];

    unpackPhase = "true";

    installPhase = ''
      mkdir -p $out/bin
      cat > $out/bin/start-server1 <<'EOF'
#!/usr/bin/env bash

socat TCP-LISTEN:80,reuseaddr,fork SYSTEM:"echo -e 'HTTP/1.1 200 OK\r\nContent-Length: 11\r\nContent-Type: text/plain\r\n\r\nhello world'"
EOF
      chmod +x $out/bin/start-server1
    '';
  };

  server2 = pkgs.stdenv.mkDerivation {
    name = "server2";
    version = "1.0";

    buildInputs = [ pkgs.socat ];

    # Disable the unpackPhase as there is no source to unpack
    unpackPhase = "true";

    installPhase = ''
      mkdir -p $out/bin
      cat > $out/bin/start-server2 <<'EOF'
#!/usr/bin/env bash

socat TCP-LISTEN:81,reuseaddr,fork SYSTEM:"echo -e 'HTTP/1.1 200 OK\r\nContent-Length: 9\r\nContent-Type: text/plain\r\n\r\nhello pup'"
EOF
      chmod +x $out/bin/start-server2
    '';
  };

in
{
  server1 = server1;
  server2 = server2;
}
