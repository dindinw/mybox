MYBOX="https://raw.githubusercontent.com/dindinw/usersettings/master/vbox/mybox.sh"
MYBOX_FUNC="https://raw.githubusercontent.com/dindinw/usersettings/master/vbox/func_create_vm.sh"
CORE_LIB="https://raw.githubusercontent.com/dindinw/usersettings/master/lib/core.sh"

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

install_mybox_script "../bin" $MYBOX $MYBOX_FUNC
install_mybox_script "../lib" $CORE_LIB
