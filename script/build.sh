#!/usr/bin/env zsh

TMUX_VERSION="$(gh release view --repo tmux/tmux --json tagName --jq .tagName)"
docker build --build-arg GITHUB_TOKEN="$(gh auth token)" --build-arg TMUX_VERSION=$TMUX_VERSION -t tmux-builder ./

CONTAINER="$(docker run -d tmux-builder true)"
docker cp "$CONTAINER:/build-result.tar.gz" ./
docker stop $CONTAINER
docker rm $CONTAINER
