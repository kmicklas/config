{ config, pkgs, ... }:

{
  services.xserver.libinput.enable = true;

  services.xserver.libinput.touchpad.accelSpeed = "1.0";
  services.xserver.libinput.touchpad.accelProfile = "adaptive";

  services.xserver.libinput.touchpad.naturalScrolling = true;

  services.xserver.libinput.touchpad.tapping = false;
}
