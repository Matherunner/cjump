cj() {
	output=$(cjump jump "$@")
	if [[ $? -ne 0 ]]; then
		return
	fi

	declare -a candidates
	local entry
	while read -r entry; do
		candidates+=("$entry")
	done <<< "$output"

	local count=${#candidates[@]}
	if [[ $count -eq 1 ]]; then
		cd -- "${candidates[0]}"
	else
		printf 'Multiples matches found.\n'
		printf '\n'
		local index
		for ((index=1; index < $count; ++index)); do
			printf '   (%d) %s\n' "$index" "${candidates[$index]}"
		done
		printf '\n'

		local choice
		while true; do
			read -erp 'Which one to jump to? ' choice
			if [[ $choice =~ ^[0-9]+$ && $choice -lt ${#candidates[@]} ]]; then
				break
			else
				printf 'Please input a valid index to the list above.\n' 1>&2
			fi
		done

		cd -- "${candidates[$choice]}"
	fi
}
