if-shell -F "#{pane_at_bottom}" \
  "" \
  "kill-pane -t :.+" 
split-window -l 10 -v "build.sh #{local_build}"
select-pane -t :.+
