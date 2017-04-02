cj() {
	if [[ -z $@ ]]; then
		cjump alias
	else
		output=$(cjump jump -- "$@")
		[[ $? -eq 0 && -n $output ]] && cd -- "$output"
	fi
}
