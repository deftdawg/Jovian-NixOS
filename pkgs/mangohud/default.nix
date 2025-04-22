{ mangohud', fetchFromGitHub }:
mangohud'.overrideAttrs {
  version = "0.8.1.r40";

  src = fetchFromGitHub {
    owner = "flightlessmango";
    repo = "mangohud";
    rev = "6ca95df5f8a687f5fca3fa5a707cc758ffdf8cf8";
    hash = "sha256-9dsEeD0hcNHBMqRWi7Ek7zxsZrsbaTgPg/HNCxeOAQ0=";
  };
}
