MYBOX="https://raw.githubusercontent.com/dindinw/usersettings/master/vbox/mybox.sh"
MYBOX_FUNC="https://raw.githubusercontent.com/dindinw/usersettings/master/vbox/func_create_vm.sh"
CORE_LIB="https://raw.githubusercontent.com/dindinw/usersettings/master/lib/core.sh"
MYBOX_KEY="https://raw.githubusercontent.com/dindinw/usersettings/master/vbox/keys/mybox"
MYBOX_PUB_KEY="https://raw.githubusercontent.com/dindinw/usersettings/master/vbox/keys/mybox.pub"
if [[ "$arch" == "win" ]]; then
    NC="https://github.com/dindinw/usersettings/raw/master/vbox/nc.exe"
fi


function install_mybox_script(){
    local target="$1"
    shift
    local URLS="$@"
    
    for url in $URLS; do
        local file=$(basename $url)
        curl -s -L $url -O
        if [[ $? -eq 0 ]];then
            echo "Download $file OK!"
            echo "Install $file to $target folder"
            mv $file $target
        fi
    done
}

install_mybox_script "../bin" $MYBOX $MYBOX_FUNC $NC
install_mybox_script "../lib" $CORE_LIB
install_mybox_script "../bin/keys" $MYBOX_KEY $MYBOX_PUB_KEY
