{
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkg-config,
  rustc,
  cargo,
  rustPlatform,
  systemd,
  dbus,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "xdg-desktop-portal-gamescope";
  version = "0.1.19.89fcd9a";

  src = fetchFromGitHub {
    owner = "Jovian-Experiments";
    repo = "xdg-desktop-portal-gamescope";
    rev = "89fcd9adc577c95de61bac7c7b7e4a2559d74bd3";
    hash = "sha256-wqZnmjz4xIGNOvK7CfQJq2Q2lxmh1PzuOTRBr4b23Xs=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit (finalAttrs) src;
    hash = "sha256-siYdXhnR32OAaDRm/4OWFmlIlS8gYhZKjX+ddzrPVKw=";
  };

  env.PKG_CONFIG_DBUS_1_SESSION_BUS_SERVICES_DIR = "${placeholder "out"}/share/dbus-1/services";

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    rustc
    cargo
    rustPlatform.cargoSetupHook
  ];

  buildInputs = [
    systemd
    dbus
  ];
})
