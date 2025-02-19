{ mesa, fetchpatch }:
# Patches from nixpkgs mesa..vendor radeonsi branch
mesa.overrideAttrs(old: {
  patches = old.patches ++ [
    # Cherry-pick the swapchain override bits from the Valve 24.3 branch
    (fetchpatch {
      url = "https://github.com/Jovian-Experiments/mesa/commit/8d0948917e651b6265bb35eab340d06eb8988c44.patch";
      hash = "sha256-PQbMfKMGabq0n4/JRhfxHl7TV88Ddf9QolqNIgdXOOk=";
    })
  ];
})
