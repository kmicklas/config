{ config, options, pkgs, ... }:

{
  nix.binaryCaches = options.nix.binaryCaches.default ++ [
    "https://nixcache.reflex-frp.org"
  ];
  nix.binaryCachePublicKeys = [
    "ryantrinkle.com-1:JJiAKaRv9mWgpVAz8dwewnZe0AzzEAzPkagE9SP5NWI="
  ];
}
