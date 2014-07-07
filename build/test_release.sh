source ./release.sh
if [[ -f "./mybox-$release.zip" ]]; then
    if [[ -e "/c/mybox" ]]; then
        if [[ -f "/c/mybox/mybox-$release.zip" ]]; then
            rm "/c/mybox/mybox-$release.zip"
        fi
        cp "./mybox-$release.zip" "/c/mybox/mybox-$release.zip"
        pushd /c/mybox
        rm -rf ./bin ./share ./lib ./README.md
        7z x mybox-$release.zip
        popd
    fi
fi