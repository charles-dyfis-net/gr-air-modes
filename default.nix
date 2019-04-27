let
  pkgs = import <nixpkgs> {};
in with pkgs; with pkgs.stdenv; mkDerivation {
  name = "gr-air-modes";
  src = ./.;
  buildInputs = [
    boost
    cmake
    gcc
    gnumake
    gnuradio
    pkgconfig
    qwt
    swig
    (python27.withPackages(ps: [ps.pyqt4 ps.numpy ps.pyzmq]))
  ];
  nativeBuildInputs = [ makeWrapper ];
  configurePhase = ''
    cmake -DCMAKE_INSTALL_PREFIX=$out
  '';
  postFixup = ''
    wrapProgram $out/bin/modes_gui  --prefix PYTHONPATH : "$out/lib/python2.7/site-packages:$PYTHONPATH"
    wrapProgram $out/bin/modes_rx   --prefix PYTHONPATH : "$out/lib/python2.7/site-packages:$PYTHONPATH"
  '';
}
