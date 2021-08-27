FROM alpine:latest
RUN apk add -U --no-cache \
    neovim git git-perl \
    tmux openssh-client bash ncurses \
    curl less man docker python3.6 build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev libbz2-dev
COPY init.vim .config/nvim/init.vim
COPY coc-settings.json .config/nvim/coc-settings.json
COPY tmux.conf .tmux.conf
COPY .bashrc .bashrc
COPY .bash_aliases .bash_aliases
RUN curl -O https://dl.google.com/go/go1.12.7.linux-amd64.tar.gz
RUN sudo chown -R root:root ./go
RUN git config --global url."https://daysgoby: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@github.com".insteadOf "https://github.com"


RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
RUN export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
RUN nvm install --lt

# Install Vim Plug for plugin management
RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Install plugins
RUN nvim +PlugInstall +qall >> /dev/null
RUN git config --global user.email smithcole@protonmail.com
RUN git config --global user.name "cole smith"
