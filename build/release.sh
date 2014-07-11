
function prepare(){

    . install_mybox.sh
    if [[ "$arch" == "win" ]]; then
        . install_msysgit_2.sh
    fi
}

function clean_mybox(){
    echo "Clean mybox script ..."
    rm ../bin/mybox.sh
    rm ../bin/func_create_vm.sh
    rm ../lib/core.sh
    if [[ "$arch" == "win" ]]; then
        rm ../bin/nc.exe
    fi
    rm ../bin/keys/mybox
    rm ../bin/keys/mybox.pub
}

function clean_msysgit(){
    echo "Clean msysgit ..."
    pushd ../share/msysgit/bin/
    for file in $(cat file_list); do
        echo rm $file
    done
    for file in $(cat file_list_curl); do
        echo rm $file
    done
    popd
}

function clean_all(){
    clean_mybox
    if [[ "$arch" == "win" ]]; then
        clean_msysgit
    fi
    if [[ -f "./mybox-$release.zip" ]]; then
        rm "./mybox-$release.zip"
    fi
    if [[ -f "mybox-$release.tar.gz" ]]; then
        rm "./mybox-$release.tar.gz"
    fi
}


function build_executable(){
    echo "Package MYBOX $release on $arch"
    if [[ "$arch" == "win" ]]; then
        7z a mybox-$release.zip ../bin ../share ../lib ../README.md -r
    else
        pushd .. >/dev/null
        chmod +x ./bin/mybox.sh
        tar -czf ./build/mybox-$release.tar.gz ./bin ./lib ./README.md
        popd > /dev/null
    fi
}

function main(){
    echo "Build MYBOX $release on $arch"
    clean_all
    prepare
    build_executable
    echo "Build MYBOX $release done!"
}

release="1.2.0"
uname=$(uname -a)
arch=""
case $uname in 
    Linux*)
        arch="linux"
        ;;
    Darwin*)
        arch="mac"
        ;;
    MINGW*|CYGWIN*)
        arch="win"
        ;;
    *)
        echo "Unknown OS $uname"
        exit 1
        ;;
esac
main 

