{
  inputplumber',
  fetchFromGitHub,
  rustPlatform,
}:
inputplumber'.overrideAttrs rec {
  version = "0.52.1";

  src = fetchFromGitHub {
    owner = "ShadowBlip";
    repo = "InputPlumber";
    tag = "v${version}";
    hash = "sha256-Jgy6fHR1gdRX6HGMSA6QkoNq9eZBwM4P3f972CwsGUk=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    hash = "sha256-/E2pmz1ohYQouLDnBCUYfpRWMc+rNEZ0FJR+RsSli04=";
  };
}
