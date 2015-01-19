
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
    for file in $(cat ../../../build/file_list); do
        if [[ -f $file ]]; then rm $file; fi
    done
    for file in $(cat ../../../build/file_list_curl); do
        if [[ -f $file ]]; then rm $file; fi
    done
    for file in $(cat ../../../build/file_list_7zip); do
        if [[ -f $file ]]; then rm $file; fi
    done
    popd
}

function clean_all(){
    clean_mybox
    if [[ "$arch" == "win" ]] && [[ "$1" == "--clean_msysgit" ]]; then
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
    # fixed mod for executable
    chmod +x ../bin/mybox.sh
    chmod +X ../bin/mybox
    # remove old build
    rm -rf ./mybox-$release.tar.gz
    # prepare parent folder
    mkdir -p ./mybox-$release

    if [[ "$arch" == "win" ]]; then
        cp -rf ../bin ../share ../lib ../README.md ./mybox-$release
        7z a mybox-$release.zip ./mybox-$release -r
    else
        cp -rf ../bin ../lib ../README.md ./mybox-$release
        tar -czf ./mybox-$release.tar.gz ./mybox-$release
    fi

    # remove parent folder
    rm -rf ./mybox-$release
}

function main(){
    echo "Build MYBOX $release on $arch"
    clean_all
    prepare
    build_executable
    echo "Build MYBOX $release done!"
}

release="1.2.2"
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

