#!/bin/zsh

# yum -y install zsh

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

SED_CMD="sed"
SED_ARGS="-i"
# 在 macOS 上，sed -i 的语法略有不同，需要添加一个额外的空字符串作为后缀，即 sed -i ''
if [[ "$(uname)" == "Darwin" ]]; then
    SED_ARGS="$SED_ARGS ''"
fi
$SED_CMD $SED_ARGS "s/plugins=(/plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-completions /" ~/.zshrc

wget https://github.com/ahmetb/kubectl-aliases/raw/master/.kubectl_aliases -O ~/.kubectl_aliases

cat >>~/.zshrc <<EOF

[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
function kubectl() { echo "+ kubectl \$@">&2; command kubectl \$@; }

EOF

source ~/.zshrc

chsh -s /bin/zsh

zsh
