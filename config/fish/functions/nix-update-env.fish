function nix-update-env
	nix-env -ir -f ~/config/nix/base-env.nix $argv; 
end
