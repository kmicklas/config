{ ... }:

{
  services.libinput.enable = true;

  services.libinput.touchpad.accelSpeed = "1.0";
  services.libinput.touchpad.accelProfile = "adaptive";

  services.libinput.touchpad.naturalScrolling = true;
  services.libinput.mouse.naturalScrolling = true;

  services.libinput.touchpad.tapping = false;
}
