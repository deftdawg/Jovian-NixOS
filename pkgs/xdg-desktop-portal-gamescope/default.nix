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
  version = "0.1.17.05b8e66";

  src = fetchFromGitHub {
    owner = "Jovian-Experiments";
    repo = "xdg-desktop-portal-gamescope";
    rev = "05b8e662ec90046c136c92d96c3bbfd8ca1e9a7f";
    hash = "sha256-H3KimDpkpq5zvZWSog512To/tQksI7nMDULQz+rIkvQ=";
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
