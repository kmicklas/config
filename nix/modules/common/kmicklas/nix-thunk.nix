{ pkgs, ... }:

{
  home.packages = [
    # TODO: Get nix-thunk from haskellPackages once updated.
    (pkgs.haskellPackages.extend (self: super: {
      nix-thunk = pkgs.haskell.lib.doJailbreak (self.callHackageDirect {
        pkg = "nix-thunk";
        ver = "0.2.0.2";
		  	sha256 = "0af0days52223ahda1v8l5nassdn924yhinh8fr3madpzmiymmvp";
      } {});
      cli-extras = pkgs.haskell.lib.doJailbreak (self.callHackageDirect {
        pkg = "cli-extras";
        ver = "0.1.0.1";
		  	sha256 = "1hnmk8jm9zrhcv8vz9raj0p26svc0rd47zc7nz58sja6jsakcaq2";
      } {});
      cli-git = pkgs.haskell.lib.doJailbreak (self.callHackageDirect {
        pkg = "cli-git";
        ver = "0.1.0.1";
		  	sha256 = "0kqnzkz73iid5i1lcbgvdkf2pip3sapc7px42c1525cga13bhgkn";
      } {});
      cli-nix = self.callHackageDirect {
        pkg = "cli-nix";
        ver = "0.1.0.1";
		  	sha256 = "1kcr33w8kkyyynml0i20zdia792jprbg4av7f5dajvy4a2l2vmgj";
      } {};
      unliftio-core = super.unliftio-core_0_2_0_1;
    })).nix-thunk
  ];
}
