{ 
  decky-loader,
  fetchFromGitHub,
  pnpm_9,
}:
decky-loader.overridePythonAttrs rec {
  pname = "decky-loader";
  version = "3.1.9-pre1";

  src = fetchFromGitHub {
    owner = "SteamDeckHomebrew";
    repo = "decky-loader";
    rev = "v${version}";
    hash = "sha256-EzUgZ1IdzS6H3eknfnTiqBppqZa+LvwaBikjTLs6sVs=";
  };

  pnpmDeps = pnpm_9.fetchDeps {
    fetcherVersion = 1;
    inherit pname version src;
    sourceRoot = "${src.name}/frontend";
    hash = "sha256-HS3PWLxIoH/1/ir510eOLEMVMEdXBOhvYHTZBMnCB2Q=";
  };
}