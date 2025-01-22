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


if ! command -v chsh > /dev/null 2>&1; then
    # 对于 CentOS 或其他基于 RPM 的系统
    if [[ -f /etc/redhat-release ]]; then
        yum install -y util-linux-user
    # 对于 Ubuntu 或其他基于 DEB 的系统
    elif [[ -f /etc/debian_version ]]; then
        apt-get update
        apt-get install -y passwd
    # 对于其他系统，可以根据需要添加更多的检查和安装逻辑
    else
        echo "Unsupported Linux distribution. Please install chsh manually."
    fi
fi

if command -v chsh > /dev/null 2>&1; then
    chsh -s /bin/zsh
fi

zsh
