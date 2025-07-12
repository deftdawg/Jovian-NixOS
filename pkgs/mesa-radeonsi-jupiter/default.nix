{ mesa, fetchFromGitHub }:
let
  version = "25.1.4";
  jupiterVersion = "radeonsi-25.1.5";
in
mesa.overrideAttrs(old: {
  version = "${version}.${jupiterVersion}";
  
  src = fetchFromGitHub {
    owner = "Jovian-Experiments";
    repo = "mesa";
    rev = jupiterVersion;
    hash = "sha256-G82GHYeEeP9U5uxr8nvX4fk605UszHkumAzO7IOZu1s=";
  };

  mesonFlags = old.mesonFlags ++ [
    "-D radeonsi-build-id=53d063d06f3d5b95f1ffc56a00972475e31e57ac"
  ];
})
