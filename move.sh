moveSingleFileToDirectory() {
	file="$1"
	dir="$2"

	# If destination file not exist then created
	if [[ ! -e "$dir/$file" ]]; then
		mv -n "$file" "$dir/$file"
		exit 0
	fi

	index=1

	for i in "$dir"/*; do
		newfileName=$file

		while [[ "$i" == "$dir/$newfileName" ]]; do
			newfileName=$(echo "$i" | sed -E "s|(\w+)\.(\w+)|\1_$index\.\2|g;")
			newfileName=${newfileName/$dir\//}

			while [[ -e "$dir/$newfileName" ]]; do
				index=$(($index + 1))
				newfileName=$(echo "$i" | sed -E "s|(\w+)\.(\w+)|\1_$index\.\2|g;")
				newfileName=${newfileName/$dir\//}
			done

			mv -n "$1" "$dir/$newfileName"
		done
	done

	echo "ihe"
}

moveAllFilesOfDirectoryToAnotherDirectory() {
	echo "directory"

}

main() {
	if [[ -d $1 ]]; then
		moveAllFilesOfDirectoryToAnotherDirectory $1 $2
		exit 0
	fi

	if [[ -e $1 ]]; then
		moveSingleFileToDirectory $1 $2
		exit 0
	else
		echo "$1 does not exist"
		exit 1
	fi
}

main "$@"
