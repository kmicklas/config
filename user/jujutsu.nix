{ config, ... }:

{
  programs.jujutsu.enable = true;
  programs.jujutsu.settings = {
    user.name = "Ken Micklas";

    ui.default-command = "log";
    ui.conflict-marker-style = "git";

    "--scope" = [
      {
        "--when".environments = [ "JJUI" ];
        ui.diff-formatter = "${config.programs.delta.package}/bin/delta";
      }
    ];

    aliases.add = [
      "--config" "snapshot.max-new-file-size=1GB" "file" "track"
    ];

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

    actions = [
      {
        name = "git.push_allow_empty_description";
        lua = ''
          jj_async("git", "push", "--allow-empty-description")
          revisions.refresh()
        '';
        key = "G";
        scope = "revisions";
        desc = "push allowing empty description";
      }
    ];
  };

  programs.jjui.configLua = /* lua */ ''
    function setup(config)
      local escape_bindings = {}

      for _, binding in ipairs(config.bindings) do
        for _, key in ipairs(binding.key or {}) do
          if key == "esc" then
            table.insert(escape_bindings, {
              action = binding.action,
              desc = binding.desc,
              key = "ctrl+c",
              scope = binding.scope,
            })
            break
          end
        end
      end

      for _, binding in ipairs(escape_bindings) do
        config.bind(binding)
      end

      config.bind({
        action = "ui.quit",
        key = "ctrl+c",
        scope = "revisions",
      })
    end
  '';
}
