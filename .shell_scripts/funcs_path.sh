fp() {
    local input_path=${1:-"."}
    local resolved_path
    local dir_path

    resolved_path=$(realpath "$input_path")

    if [[ -d $resolved_path ]]; then
        dir_path=${resolved_path%/}
    else
        dir_path=$resolved_path
    fi

    while [[ -h $dir_path ]]; do
        dir_path=$(readlink "$dir_path")
    done

    echo "$dir_path"
}

hp() {
    echo "${USERNAME}@$(ifconfig | grep -E "^en0" -A 10 | grep -o "inet [0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+" | cut -d ' ' -f 2):$(fp $1)"
}
