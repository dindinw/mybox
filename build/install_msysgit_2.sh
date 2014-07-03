# using file_list 

readonly MSYSGIT_BIN="https://github.com/msysgit/msysgit/raw/master/bin/"
pushd ../share/msysgit/bin/
for file in $(cat file_list); do
    echo Download $file from GitHub
    if [[ ! -f $file ]];then 
        curl -s -L $MSYSGIT_BIN$file -O
    fi
done
popd