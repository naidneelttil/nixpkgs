


{ stdenv, lib, fetchFromGitHub, ncurses, flex, bison, gcc, gdb, groff, util-linux}:


stdenv.mkDerivation rec {
  pname = "evilhack";
  version = "0.8.3";

  # For https://github.com/k21971/EvilHack
  src = fetchFromGitHub {
    owner = "k21971";
    repo = "EvilHack";
    rev = "0.8.3"; # If there is a release like v1.0, otherwise put the commit directly
    sha256 = "b9f0Lx9mozozJFWWacsTc8BLtab6GFjuC+BiV1nRbSY=";

  };

  buildInputs = [
     ncurses
     gdb
  ];

  nativeBuildInputs = [
     flex
     bison
     gcc
     groff
     util-linux
  ];

 #makeFlags = [ "PREFIX=$(out)" ];
 # sed -i 's\HACKDIR=$(PREFIX)/games/$(GAME)dir\HACKDIR=$(PREFIX)/$(GAME)dir\g' linux

#    pushd sys/unix/hints
#     sed -i 's/PREFIX=$(wildcard ~)/PREFIX=''${out}/g' linux
#     popd

 postPatch = ''

     substituteInPlace sys/unix/hints/linux \
        --replace "PREFIX=\$(wildcard ~)" "PREFIX=$out"
  '';

  configurePhase = ''
     pushd sys/unix
     cat hints/linux
     echo "this is the real output of hints"
     sh setup.sh hints/linux
     popd
  '';



  buildPhase = ''
    make all
    make install
    mkdir -p $out/bin
    mkdir -p $out/games
    mv $out/games/evilhack $out/bin/

    chmod +x $out/bin/evilhack
  '';
}
