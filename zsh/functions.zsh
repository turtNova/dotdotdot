# emulate -LR zsh
mkcdir() {
    mkdir $1
    cd $1
}

# ssh: OPEN
ssho() {
    eval $(ssh-agent)
    ssh-add ~/.ssh/keys/*
}

# git add commit all
gaca() {
    if [[ -z $SSH_AGENT_PID ]]; then
        ssho
    fi
    git add .
    git commit --all --verbose --message "$*"
    git push
}

goodnight() {
    killall -15 brave
    if [ "$1" = "-r" ]; then
        echo restarting
        shutdown -r "+0"
    else
        shutdown -h "+0"
    fi
}

rojomap() {
    tmux split-window -hd rojo sourcemap --watch default.project.json --output sourcemap.json
    rojo serve
    # if [[ "${1:l}" = "tmux" ]]; then
    # fi
}

rbxnew() {
    type=""
    content=""
    case "${1}" in
        "e")
            type=".model.json"
            content="{\n    \"ClassName\": \"RemoteEvent\"\n}"
            ;;
        "s")
            type=".server.luau"
            ;;
        "c")
            type=".client.luau"
            ;;
        *)
            type=".luau"
            ;;
    esac
    echo "${content}" > "${2}${type}"
}

# ==============================   WN
wn() {
    dir="/data/media"
    dirs=($dir/*)
    type="$1"
    content="$2"
    season="$3"
    episode="$4"

    yo() {
        if [[ -z ${(P)1} ]]; then
            c=0
            for i in $dirs; do
                ((c++))
                echo "[$c] ${i##*/}"
            done
            echo -n "Which $1: "
            read $1
            if [[ -z "${(P)1}" ]]; then
                echo "wn: ur ass picked nothing"
                return 1
            fi
        fi
        echo "${1} chosen: ${dirs[${(P)1}]##*/}"
        return 0
    }

nextdir() {
    dir="${dirs[${(P)1}]}"
    dirs=($dir/*)
    echo $dir
    eval ${1}=\"${dir##*/}\"
}

yo type
nextdir type
yo content
nextdir content
if [[ $type = movies ]]; then
    mpv $dir & disown; exit
fi
yo season
nextdir season
yo episode

vidpath="$dirs[$episode]"
profile="$content/$season"
profileopt="--profile=${profile//,/\\,}"
opts=("--terminal=yes" "--input-ipc-server=/tmp/mpvscriptsocket")

case "$type" in
    *)
        if $(mpv --profile=help | grep -q $profile); then
            echo yup
            mpv $profileopt $opts $vidpath & disown
            sleep 0.5
            echo show-text \"Hi chat\" | socat - /tmp/mpvscriptsocket
        else
            echo nop
            echo -e "\n[$profile]\nprofile=anime" >> ~/.config/mpv/profiles.conf
            mpv $profileopt $opts $vidpath & disown
            sleep 0.5
            echo show-text \"Made a profile for $profile\" 5000 | socat - /tmp/mpvscriptsocket
        fi
        ;;
    *)
        echo tf is that
        ;;
esac
exit
}
