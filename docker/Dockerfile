FROM ubuntu:18.04

ARG uid
ARG gid
ARG user
ARG group
ARG pass

USER root
RUN apt update && apt install -y --no-install-recommends sudo git zsh openssh-server mosh ca-certificates
RUN groupadd -f -g $gid -o $group && useradd -u $uid -g $gid -ms /usr/bin/zsh -G sudo $user && passwd -d $user
RUN mkdir -p /run/sshd

RUN apt install -y --no-install-recommends less locales

# mosh
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen ; locale-gen

# To build tmux
RUN apt install -y --no-install-recommends bison libncurses5-dev libevent-dev curl gcc make

WORKDIR /home/$user
USER $user
RUN git clone --recursive --shallow-submodules https://github.com/vekkt0r/dotfiles src/dotfiles && cd src/dotfiles && ./bootstrap.sh

# Latest tmux
RUN curl -L https://github.com/tmux/tmux/releases/download/3.2-rc/tmux-3.2-rc4.tar.gz | tar zx \
  && cd tmux-3.2-rc4 && ./configure --prefix=$HOME && make -j8 && make install \
  && cd .. && rm -rf tmux-3.2-rc4
COPY init.sh .

USER root
RUN echo $user:$pass | chpasswd
RUN apt remove -y tmux

ENV TERM=xterm-256color
ENV LANG=en_US.UTF-8
ENV LC_TYPE=en_US.UTF-8

USER $user
ENTRYPOINT /bin/zsh

EXPOSE 22 60000/udp
