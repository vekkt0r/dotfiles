alias c="cd .."
alias ltr='ls -ltr'
alias ds="docker exec -it \$(docker ps -l | tail -n1 | awk '{print \$NF}') /bin/bash"
