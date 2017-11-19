function v
  nvim $argv; 
  # The fact that this does anything should be enough to win any argument about
  # how wrong the Unix philosophy is:
  set TERM $TERM
end
