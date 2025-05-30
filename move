#!/bin/bash

moveSingleFileToDirectory() {
	file="$1"
	dir="$2"

	#? If destination file not exist then created
	if [[ ! -e "$dir/${file/[a-z]*\//}" ]]; then
		mv -n "$file" "$dir/${file/[a-z]*\//}"
		return 0
	fi

	#? rm src. dir name
	#? foo/1.txt => 1.txt
	file="${file/[a-z]*\//}"

	index=1

	for destinationFile in "$dir"/*; do
		#? rm dest. dir name
		#? bar/1.txt => 1.txt
		destinationFile="${destinationFile/$dir\//}"

		while [[ "$destinationFile" == "$file" ]]; do
			file=$(echo "$destinationFile" | sed -E "s|(\w+)\.(\w+)|\1_$index\.\2|g;")

			while [[ -e "$dir/$file" ]]; do
				index=$(($index + 1))
				file=$(echo "$destinationFile" | sed -E "s|(\w+)\.(\w+)|\1_$index\.\2|g;")
			done

			mv -n "$1" "$dir/$file"
		done
	done

}

moveAllFilesOfDirectoryToAnotherDirectory() {
	for file in "$1"/*; do
		moveSingleFileToDirectory "$file" "$2"
	done
}

main() {
	if [[ -d "$1" ]]; then
		moveAllFilesOfDirectoryToAnotherDirectory "$1" "$2"
		exit 0
	fi

	if [[ -e "$1" ]]; then
		moveSingleFileToDirectory "$1" "$2"
		exit 0
	else
		echo "$1 does not exist"
		exit 1
	fi
}

main "$@"
