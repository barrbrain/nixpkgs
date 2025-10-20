{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchpatch2,
  autoreconfHook,
  pkg-config,
  file,
  libuv,
  lz4,
  sqlite,
  lxd-lts,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "dqlite";
  version = "1.18.3-fixed";

  src = fetchFromGitHub {
    owner = "canonical";
    repo = "dqlite";
    tag = "v${finalAttrs.version}";
    hash = "sha256-/x5ve/Kc6PThAuhwUDN/aef8ye5hd3TJXQqcqRJhJb8=";
  };

  nativeBuildInputs = [
    autoreconfHook
    file
    pkg-config
  ];
  buildInputs = [
    libuv
    lz4
    sqlite
  ];

  enableParallelBuilding = true;

  # tests fail
  doCheck = false;

  outputs = [
    "dev"
    "out"
  ];

  passthru.tests = {
    inherit lxd-lts;
  };

  meta = {
    description = ''
      Expose a SQLite database over the network and replicate it across a
      cluster of peers
    '';
    homepage = "https://dqlite.io/";
    license = lib.licenses.asl20;
    maintainers = [ ];
    platforms = lib.platforms.linux;
  };
})
