{ wireplumber', fetchFromGitHub }:
wireplumber'.overrideAttrs(_: {
  version = "0.5.7";

  src = fetchFromGitHub {
    owner = "Jovian-Experiments";
    repo = "wireplumber";
    rev = "0.5.7-jupiter1.2";
    hash = "sha256-+9pl2vuaaESTUmGh9ba8cksbUS+B7Y6F0lvCZFFflFA=";
  };
})
