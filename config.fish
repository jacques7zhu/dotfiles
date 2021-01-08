set PATH $HOME/bin/ $PATH
set PATH /Applications/CMake.app/Contents/bin/ $PATH
set PATH $HOME/.npm-global/bin/ $PATH
set PATH $HOME/.gem/ruby/2.6.0/bin $PATH

# set -x AWS_DEFAULT_PROFILE default
set -x AWS_DEFAULT_PROFILE jacques7zhu
set -x AWS_DEFAULT_PROFILE cn
set -x SCONS_LIB_DIR /usr/local/lib/python3.7/site-packages/scons-3.0.1
set -gx LDFLAGS "-L/usr/local/opt/zlib/lib"
set -gx CPPFLAGS "-I/usr/local/opt/zlib/include"
set -gx LDFLAGS $LDFLAGS "-L/usr/local/opt/llvm/lib"
set -gx CPPFLAGS $CPPFLAGS "-I/usr/local/opt/llvm/include"
set -g fish_user_paths "/usr/local/opt/llvm/bin" $fish_user_paths
#set -x http_proxy http://127.0.0.1:1087
#set -x https_proxy http://127.0.0.1:1087

# for install python
set -gx LDFLAGS $LDFLAGS "-L/usr/local/opt/libffi/lib"
set -gx PKG_CONFIG_PATH "/usr/local/opt/libffi/lib/pkgconfig"

# for SAML
set -x GOOGLE_USERNAME yuanjie.zhu@kolmostar.com
set -x GOOGLE_SP_ID 706665526336
set -x GOOGLE_IDP_ID C02vmhuhp

function cwd
    pwd | pbcopy
end

function pip
    pip3 $argv
end

function printjson
    python -m json.tool $argv
end

function mkcd
    mkdir -p $argv
    cd $argv
end

function act_venv
    if test -d venv
        source venv/bin/activate.fish
    end
end

function act_git_venv
    if test -d ~/Documents/git/venv3.8
        source ~/Documents/git/venv3.8/bin/activate.fish
    end
end

function python
    python3 $argv
end

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

function vim
    nvim $argv
end

# https://github.com/fish-shell/fish-shell/issues/583
function __check_pwd --on-variable PWD --description 'ls when cd'
  status --is-command-substitution; and return
  ls
end

function vimdiffbin
    vimdiff (hexdump -v $argv[1] | psub) (hexdump -v $argv[2] | psub)
end

function ssh-cs1a
    # please run gsts --force before
    gsts --force
    /Users/kolmostar011/Downloads/aws-server-tutorial-secure1-2/script/kasic_connect.sh pre-x2go-cs x2go_secure1_a cs_secure1_a yuanjie && ssh -J x2go_1a cs1a
end

function rsync-cs1a
    rsync -Parq -e "ssh -J x2go_1a" $argv[1] cs1a:$argv[2]
end

status --is-interactive; and source (pyenv init -|psub)

# set -g fish_key_bindings fish_vi_key_bindings
#

# for bison
set -g fish_user_paths "/usr/local/opt/bison/bin" $fish_user_paths
set -gx LDFLAGS "-L/usr/local/opt/bison/lib"

# ghcup-env
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
test -f /Users/kolmostar011/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /Users/kolmostar011/.ghcup/bin $PATH

#set -x VERILATOR_ROOT /Users/kolmostar011/Documents/git/third-party/verilator
alias gs gitspace

act_git_venv
# alias jekyll $HOME/.gem/ruby/2.6.0/bin/jekyll
# alias bundle $HOME/.gem/ruby/2.6.0/bin/bundle
# alias bundler $HOME/.gem/ruby/2.6.0/bin/bundler
