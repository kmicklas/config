function generate-hasktags
  nix-shell -p haskellPackages.hasktags --run "hasktags ." $argv;
end
