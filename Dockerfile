FROM ubuntu:20.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN apt update && apt install -y software-properties-common
RUN apt install -y python3-pip

RUN apt-add-repository ppa:fish-shell/release-3 && apt-get update && apt-get install -y git fish tmux curl

RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN curl -sSL https://get.haskellstack.org/stable/linux-x86_64.tar.gz -o stack-2.5.1-linux-x86_64.tar.gz 
RUN tar -zxvf stack-2.5.1-linux-x86_64.tar.gz && mv stack-2.5.1-linux-x86_64/stack /usr/local/bin/

# nodejs
RUN curl -fsSL https://deb.nodesource.com/setup_15.x -o setup_nodejs.sh
RUN chmod +x ./setup_nodejs.sh && ./setup_nodejs.sh && apt-get install -y nodejs

# change default shell to fish
RUN echo /bin/fish | tee -a /etc/shells && chsh -s /bin/fish

# neovim
# RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
#     && chmod u+x nvim.appimage && ./nvim.appimage --appimage-extract \
#     && ln -s /squashfs-root/AppRun /usr/bin/nvim \
#     && ln -sf /usr/bin/nvim /usr/bin/vim
RUN apt-get install -y neovim
ADD . dotfiles

ENTRYPOINT [ "/bin/fish" ]