{ ... }:

{
  programs.jujutsu.enable = true;
  programs.jujutsu.settings = {
    user.name = "Ken Micklas";
  };

  programs.delta.enableJujutsuIntegration = true;

  programs.jjui.enable = true;
}
