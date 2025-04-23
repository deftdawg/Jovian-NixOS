{
  inputplumber',
  fetchFromGitHub,
  rustPlatform,
}:
inputplumber'.overrideAttrs rec {
  version = "0.54.0";

  src = fetchFromGitHub {
    owner = "ShadowBlip";
    repo = "InputPlumber";
    tag = "v${version}";
    hash = "sha256-fo0ab+UzhoHX9kB2snwtItwMjQdCFk4+K7AV4mbEj7o=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    hash = "sha256-0oKBJb5qcV2ndOhJl2MZG/0+w2ZpnBZ0OqmmJgmQ7OQ=";
  };
}
