# using file_list 

readonly MSYSGIT_BIN="https://github.com/msysgit/msysgit/raw/master/bin/"
readonly MSYSGIT_MINGW_BIN="https://github.com/dindinw/msysgit/raw/master/mingw/bin/"
pushd ../share/msysgit/bin/
for file in $(cat file_list); do
    echo Download $file from GitHub
    if [[ ! -f $file ]];then 
        curl -s -L $MSYSGIT_BIN$file -O
    fi
done
for file in $(cat file_list_curl); do
    echo Download $file from GitHub Mysys mingw
    if [[ ! -f $file ]];then 
        curl -s -L $MSYSGIT_MINGW_BIN$file -O
    fi
done
popd