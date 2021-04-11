{ pkgs, ... }:

{
  home.packages = [
    # TODO: Get nix-thunk from haskellPackages once updated.
    (pkgs.haskellPackages.extend (self: super: {
      nix-thunk = self.callHackageDirect {
        pkg = "nix-thunk";
        ver = "0.2.0.3";
		  	sha256 = "0w5yk1nllldfbf8vmrbhj90j902ffm5kq43xgj9y2y9p9ja8lh6m";
      } {};
      cli-extras = self.callHackageDirect {
        pkg = "cli-extras";
        ver = "0.1.0.2";
		  	sha256 = "0jwq4npyd35q6qwfxg0dnzmv0nz0fpkcp6dgppq0hc7bxxbxmsl1";
      } {};
      cli-git = self.callHackageDirect {
        pkg = "cli-git";
        ver = "0.1.0.2";
		  	sha256 = "1vgy8pyqlmwy1kkf6lywdkykvhpfrz9vzp0zym9mg3xx5pqvana1";
      } {};
      cli-nix = self.callHackageDirect {
        pkg = "cli-nix";
        ver = "0.1.0.1";
		  	sha256 = "1kcr33w8kkyyynml0i20zdia792jprbg4av7f5dajvy4a2l2vmgj";
      } {};
      which = self.callHackageDirect {
        pkg = "which";
        ver = "0.2";
		  	sha256 = "1g795yq36n7c6ycs7c0799c3cw78ad0cya6lj4x08m0xnfx98znn";
      } {};
      unliftio-core = super.unliftio-core_0_2_0_1;
    })).nix-thunk
  ];
}
