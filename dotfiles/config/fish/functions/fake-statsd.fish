function fake-statsd
  nix-shell -p ncat --run 'ncat -l 8125 -o /dev/stdout --keep-open --udp --exec "/bin/cat"' $argv;
end
