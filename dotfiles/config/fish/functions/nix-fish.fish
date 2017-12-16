# Defined in - @ line 0
function nix-fish --description 'alias nix-fish=nix-shell --run fish'
	nix-shell --run fish $argv;
end
