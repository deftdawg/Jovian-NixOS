{
  rustPlatform,
  fetchFromGitHub,
  replaceVars,
  jupiter-hw-support,
  jovian-stubs,
  steamos-polkit-helpers,
  steamdeck-firmware,
  jupiter-dock-updater-bin,
  iwd,
  trace-cmd,
  iw,
  pkg-config,
  udev,
}:
rustPlatform.buildRustPackage rec {
  pname = "steamos-manager";
  version = "25.5.2";

  src = fetchFromGitHub {
    owner = "Jovian-Experiments";
    repo = "steamos-manager";
    rev = "v${version}";
    hash = "sha256-L5lM7qWjDaoKFLn1W7OCQc3SNDregcTwkaF02e38apQ=";
  };

  cargoHash = "sha256-JVnVPoxedyZFZslJhFC2fs/YFDQEWRnQgMaNWcQzfVE=";

  # tests assume Steam Deck hardware and FHS paths
  doCheck = false;

  patches = [ 
    (replaceVars ./hardcode-paths.patch
    {
      stubs = jovian-stubs;
      steamDeckFirmware = steamdeck-firmware;
      jupiterDockUpdaterBin = jupiter-dock-updater-bin;
      hwsupport = jupiter-hw-support;
      polkitHelpers = steamos-polkit-helpers;
      iwd = iwd;
      traceCmd = trace-cmd;
      iw = iw;
      out = null;
    })
    # FIXME: build steamos-log-submitter and reenable this maybe?
    ./disable-ftrace.patch
  ];

  postPatch = ''
    substituteInPlace \
      src/daemon/{root,user}.rs \
      src/platform.rs \
      data/*/*.service \
      --replace-fail "@out@" "$out"
  '';

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ udev ];

  installPhase = ''
    runHook preInstall

    make DESTDIR=$out install
    mv $out/usr/* $out/
    rm -r $out/usr/

    runHook postInstall
  '';
}