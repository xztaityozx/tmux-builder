FROM ubuntu:latest

ARG TMUX_VERSION

RUN apt update && apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install -y libevent-dev ncurses-dev build-essential bison pkg-config

CMD cd /work && ./configure --prefix=/dest && make && make install
