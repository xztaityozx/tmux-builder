FROM ubuntu:latest

ARG TMUX_VERSION
ARG GITHUB_TOKEN

RUN apt-get update && apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libevent-dev ncurses-dev build-essential bison pkg-config wget tar git

RUN wget https://github.com/cli/cli/releases/download/v2.21.0/gh_2.21.0_linux_amd64.deb
RUN dpkg -i ./gh_*

RUN gh release download ${TMUX_VERSION} --repo tmux/tmux
RUN tar xzf ./tmux-*
WORKDIR $PWD/tmux-${TMUX_VERSION}
RUN ./configure --prefix=/dest
RUN make
RUN make install

RUN wget https://raw.githubusercontent.com/zsh-users/zsh/master/Completion/Unix/Command/_tmux
RUN chmod +x _tmux
RUN cp _tmux /dest/_tmux
RUN tar cfz /build-result.tar.gz /dest/*

CMD bash
