#!/bin/zsh

# yum -y install zsh

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -i "s/plugins=(/plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-completions /" ~/.zshrc

wget https://github.com/ahmetb/kubectl-aliases/raw/master/.kubectl_aliases -O ~/.kubectl_aliases

cat >>~/.zshrc <<EOF

[ -f ~/.kubectl_aliases ] && source ~/.kubectl_aliases
function kubectl() { echo "+ kubectl \$@">&2; command kubectl \$@; }

EOF

source ~/.zshrc

chsh -s /bin/zsh

zsh
