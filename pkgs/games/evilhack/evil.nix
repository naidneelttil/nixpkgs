


{ stdenv, lib, fetchFromGitHub, ncurses, flex, bison, gcc, gdb}:

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
  ];

  nativeBuildInputs = [
     flex
     bison

  ];

  makeFlags = [ "PREFIX=$(out)" ];

  configurePhase = ''
     pushd sys/unix
     sh setup.sh hints/linux
     popd
  '';


#  buildPhase = ''
#    gcc program.c -o myprogram
#  '';

  installPhase = ''
    ls $out/
    mkdir -p $out/bin
    cp ~/games/evilhack $out/bin
    cp -r ~/games/evilhackdir $out/bin

    chmod +x $out/bin/evilhack
  '';
}
