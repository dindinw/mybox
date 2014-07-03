
readonly GITHUB="https://github.com"
readonly MSYSGIT_LATEST_RELEASE_URL="$GITHUB/msysgit/msysgit/releases/latest"

LATEST_PORTABLE_DOWN_URL=""

function download_msysgit(){

    local match="Git-"

    case $1 in ""|default);; net|netinstall) match="msysGit-"; ;; port|portable|7z) match="PortableGit-"; ;; esac; 

    for url in $(curl -s -L $MSYSGIT_LATEST_RELEASE_URL | grep "\/msysgit\/msysgit\/releases\/download" | sed -e "s/.*href=\"//" -e "s/\".*//"); do
        echo ${url##*\/}|grep "^$match" > /dev/null
        if [[ $? -eq 0 ]]; then
            LATEST_PORTABLE_DOWN_URL="$GITHUB$url"
            local msysgit=$(basename $LATEST_PORTABLE_DOWN_URL)
            echo "The latest portable msysgit file : $msysgit"
            if [[ ! -f $msysgit ]];then
                echo "Download $msysgit ... "
                curl -L $LATEST_PORTABLE_DOWN_URL -O
                if [[ $? -eq 0 ]];then 
                    echo "Download $msysgit ok!"
                fi
            else
                echo "$msysgit exist, use local file."
            fi
        fi
    done
}

function extract_bin(){
    source ../lib/core.sh
    local msysgit=$(basename $LATEST_PORTABLE_DOWN_URL)
    echo "mkdir tmp"
    mkdir tmp
    if [[ $? -eq 0 ]]; then
        echo "extract $msysgit ..."
        7z x "$msysgit" -o"tmp" >/dev/null
    fi
}

function install_to_share(){

    for folder in $(ls -d ./tmp/*/);do
        local f=$(basename $folder)
        if [[ $f == "bin" ]]; then
            echo install msysgit $f
            mv $folder ../share/msysgit/
        fi
    done
    rm -rf tmp
    echo "Install msysgit done!"
}

download_msysgit portable

extract_bin

install_to_share