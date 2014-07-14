. ./release.sh

if [[ "$arch" == "win" ]]; then
    release_file="mybox-$release.zip"
    release_folder="/c/mybox"
    extract_cmd="7z x "
else
    release_file="mybox-$release.tar.gz"
    release_folder=~/mybox
    extract_cmd="tar xzf "
fi
#echo $release_file $release_folder

if [[ -f "./$release_file" ]]; then
    if [[ -e $release_folder ]]; then
        if [[ -f "$release_folder/$release_file" ]]; then
            rm "$release_folder/$release_file"
        fi
        cp "./$release_file" "$release_folder/$release_file"
        pushd $release_folder > /dev/null
        rm -rf ./bin ./share ./lib ./README.md
        eval $extract_cmd $release_file
        popd /dev/null >/dev/null
        echo "Install $release_file under $release_folder done!"
    else
        echo "$release_folder not found! please create the folder before run the script."
    fi
fi