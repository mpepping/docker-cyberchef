#!/bin/bash

die(){ 
  echo "$@" >&2; exit 1;
}

get_latest_sha(){
  curl --silent "https://api.github.com/repos/$1/commits" | jq -r '.[0].sha'
}

CURRENT=$(cat ./master_sha)
REMOTE=$(get_latest_sha "gchq/CyberChef")
LENGTH=${#REMOTE}

if [ $LENGTH -ne 40 ]; then
  die "Probably couldn't fecth remote SHA"
fi

if [ "$CURRENT" != "$REMOTE" ]; then
  git checkout master
  git branch --set-upstream-to=origin/master master
  echo -n "$REMOTE" > ./master_sha
  git commit -am "Updated from ${CURRENT} to ${REMOTE}"
fi

