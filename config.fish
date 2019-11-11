set -x PATH $PATH /Applications/MATLAB_R2016b.app/bin/
set -x PATH $PATH /usr/local/Cellar/python/3.7.0/bin/
set -x AWS_DEFAULT_PROFILE default
set -x SCONS_LIB_DIR /usr/local/lib/python3.7/site-packages/scons-3.0.1
set -gx LDFLAGS "-L/usr/local/opt/zlib/lib"
set -gx CPPFLAGS "-I/usr/local/opt/zlib/include"
set -x http_proxy http://127.0.0.1:1087
set -x https_proxy http://127.0.0.1:1087

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

function python
    python3 $argv
end

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

function vim
    mvim -v $argv
end

# https://github.com/fish-shell/fish-shell/issues/583
function __check_pwd --on-variable PWD --description 'ls when cd'
  status --is-command-substitution; and return
  ls
end

status --is-interactive; and source (pyenv init -|psub)

set -g fish_key_bindings fish_vi_key_bindings
