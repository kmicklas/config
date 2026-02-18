{ ... }:

{
  programs.jujutsu.enable = true;
  programs.jujutsu.settings = {
    user.name = "Ken Micklas";

    ui.default-command = "log";

    templates.draft_commit_description = ''
      concat(
        description,
        surround(
          "\nJJ: This commit contains the following changes:\n", "",
          indent("JJ:     ", diff.stat(72)),
        ),
        "\nJJ: ignore-rest\n",
        diff.git(),
      )
    '';
  };

  programs.delta.enableJujutsuIntegration = true;

  programs.jjui.enable = true;
  programs.jjui.settings = {
    preview.show_at_start = true;
  };
}
