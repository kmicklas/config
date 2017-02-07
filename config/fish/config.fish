set fish_user_paths ~/bin
set -e fish_greeting
set fish_prompt_pwd_dir_length 0
if test -f ~/config-local/config/fish/config.fish
  . ~/config-local/config/fish/config.fish
end
for func in ~/config-local/config/fish/functions/*.fish
  . $func
end
