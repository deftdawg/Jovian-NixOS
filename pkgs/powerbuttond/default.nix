{
  lib,
  stdenv,
  fetchFromGitHub,
  replaceVars,
  pkg-config,
  libevdev,
  udev,
  jovian-steam-protocol-handler,
}:
stdenv.mkDerivation(finalAttrs: {
  pname = "powerbuttond";
  version = "3.1";

  src = fetchFromGitHub {
    owner = "Jovian-Experiments";
    repo = "powerbuttond";
    rev = "v${finalAttrs.version}";
    hash = "sha256-fYpSe6fSUn5qCEyjOeHkVSHBX2Nof+aiazYd8ymI/PM=";
  };

  patches = [
    (replaceVars ./jovian.patch {
      handler = jovian-steam-protocol-handler;
    })
  ];

  postPatch = ''
    substituteInPlace Makefile \
      --replace-fail /usr/lib/hwsupport/steamos-powerbuttond /usr/bin/steamos-powerbuttond \
      --replace-fail /usr/ /

    substituteInPlace steamos-powerbuttond.service \
      --replace-fail /usr/lib/hwsupport/steamos-powerbuttond $out/bin/steamos-powerbuttond
  '';

  nativeBuildInputs = [pkg-config];
  buildInputs = [libevdev udev];

  makeFlags = [
    "DESTDIR=$(out)"
  ];

  meta = with lib; {
    description = "Steam Deck power button daemon";
    license = licenses.bsd2;
  };
})
