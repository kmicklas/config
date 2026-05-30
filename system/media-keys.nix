{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    brightnessctl
    kbdlight
  ];

  services.actkbd.enable = true;
  services.actkbd.bindings = [
    {
      keys = [ 224 ];
      events = [
        "key"
        "rep"
      ];
      command = "${pkgs.brightnessctl}/bin/brightnessctl set 4%-";
    }
    {
      keys = [ 225 ];
      events = [
        "key"
        "rep"
      ];
      command = "${pkgs.brightnessctl}/bin/brightnessctl set +4%";
    }
    {
      keys = [ 229 ];
      events = [
        "key"
        "rep"
      ];
      command = "${pkgs.kbdlight}/bin/kbdlight down";
    }
    {
      keys = [ 230 ];
      events = [
        "key"
        "rep"
      ];
      command = "${pkgs.kbdlight}/bin/kbdlight up";
    }
  ];
}
