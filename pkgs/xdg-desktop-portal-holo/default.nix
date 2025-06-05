{
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  glib,
  dbus,
  fontconfig,
  systemd,
  xdg-desktop-portal,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "xdg-desktop-portal-holo";
  version = "0.1.11.c1b8cf1";

  src = fetchFromGitHub {
    owner = "Jovian-Experiments";
    repo = "xdg-desktop-portal-holo";
    rev = "c1b8cf151122636dc16b723e4d9b19aa30b851a6";
    hash = "sha256-fi8rPpdmqPQk7aXxG87ONYuhQximgxS2hofEldQJi8g=";
  };

  strictDeps = true;

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    glib
  ];

  buildInputs = [
    dbus
    fontconfig
    glib
    systemd
    xdg-desktop-portal
  ];
})
