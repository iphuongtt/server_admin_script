#!bin/sh
# version compare function
vercomp () {
    if [[ $1 == $2 ]]
    then
        return 0
    fi
    local IFS=.
    local i ver1=($1) ver2=($2)
    # fill empty fields in ver1 with zeros
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++))
    do
        ver1[i]=0
    done
    for ((i=0; i<${#ver1[@]}; i++))
    do
        if [[ -z ${ver2[i]} ]]
        then
            # fill empty fields in ver2 with zeros
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]}))
        then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]}))
        then
            return 2
        fi
    done
    return 0
}
# Get version for this
this_version=`cat version.txt`
latest_verion=$(wget https://raw.githubusercontent.com/iphuongtt/server_admin_script/master/version.txt -q -O -)
$( vercomp $this_version $latest_verion)
case $? in
    0) op='=';;
    1) op='>';;
    2) op='<';;
esac
mkdir -p /etc/server_admin/menu/