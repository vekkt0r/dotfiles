#!/bin/bash

read -s -p "Enter password to use for new user '$(id -un)': " pass

docker build -t dev \
  --build-arg user=$(id -un) \
  --build-arg uid=$(id -u) \
  --build-arg gid=$(id -g) \
  --build-arg group=$(id -gn) \
  --build-arg pass=${pass} \
  .
