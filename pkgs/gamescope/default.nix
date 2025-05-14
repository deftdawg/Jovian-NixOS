{ 
  lib,
  gamescope',
  fetchFromGitHub,
  fetchpatch,
}:

# NOTE: vendoring gamescope for the time being since we want to match the
#       version shipped by the vendor, ensuring feature level is equivalent.

gamescope'.overrideAttrs(old: rec {
  version = "3.16.7";

  src = fetchFromGitHub {
    owner = "ValveSoftware";
    repo = "gamescope";
    rev = version;
    fetchSubmodules = true;
    hash = "sha256-q0yTOyu47tQXorFfnmRa4wrt0KRnyelLDmfcg4iwPfs=";
  };

  # FIXME: remove hacks when https://github.com/NixOS/nixpkgs/pull/406993 makes it to channels
  patches = gamescope'.patches or [] ++ lib.optionals (lib.versionOlder gamescope'.version "3.16.7") [
    # Revert change to always use vendored stb/glm libraries
    # Upstream discussion: https://github.com/ValveSoftware/gamescope/pull/1751
    (fetchpatch {
      url = "https://github.com/ValveSoftware/gamescope/commit/baae74c4b13676fa76a8b200f21ac78f55079734.patch";
      revert = true;
      hash = "sha256-XpbyLQ4R9KgBR3hlrgPzmM7Zxr2jm4Q10zGjyhh/Qxw=";
    })
    (fetchpatch {
      url = "https://github.com/ValveSoftware/gamescope/commit/72bae179ba2ebbbc91ed07c7f66e7e4964a4cd9e.patch";
      revert = true;
      hash = "sha256-aglfGvEuycNyPlaFYxqqvPAgFpWns3xZ3B2GiAefxtg=";
    })
  ];
})
