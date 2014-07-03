
function prepare(){

    . install_mybox.sh
    . install_msysgit.sh
}

function clean_mybox(){
    echo
    rm ../bin/mybox.sh
    rm ../bin/func_create_vm.sh
    rm ../lib/core.sh
    rm ../bin/nc.exe
    rm ../bin/keys/mybox
}

function clean_msysgit(){
    echo
    rm -rf ../share/msysgit/bin
}

function clean_all(){
    clean_mybox
    clean_msysgit
    if [[ -f "./mybox-$release.zip" ]]; then
        rm "./mybox-$release.zip"
    fi
}


function build_executable(){
    7z a mybox-$release.zip ../bin ../share ../lib ../README.md -r
}

function main(){
    local release="$1"
    echo Build MYBOX $release
    prepare
    build_executable
}



clean_all
main "1.0.0"

