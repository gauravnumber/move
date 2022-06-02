moveSingleFileToDirectory() {
	file="$1"
	dir="$2"

	#? rm src. dir name
	#? foo/1.txt => 1.txt
	file=${file/[a-z]*\//}

	#? If destination file not exist then created
	if [[ ! -e "$dir/$file" ]]; then
		mv -n "$file" "$dir/$file"
		exit 0
	fi

	index=1

	for destinationFile in "$dir"/*; do
		#? rm dest. dir name
		#? bar/1.txt => 1.txt
		destinationFile=${destinationFile/$dir\//}
		# echo '$destinationFile' "$destinationFile"
		# echo "$dir"/*
		# while [[ "$destinationFile" == "$dir/$file" ]]; do
		while [[ "$destinationFile" == "$file" ]]; do
			file=$(echo "$destinationFile" | sed -E "s|(\w+)\.(\w+)|\1_$index\.\2|g;")
			# file=${file/$dir\//}
			# echo '$file' "$file"

			# while [[ -e "$file" ]]; do
			while [[ -e "$dir/$file" ]]; do
				index=$(($index + 1))
				file=$(echo "$destinationFile" | sed -E "s|(\w+)\.(\w+)|\1_$index\.\2|g;")
				# file=${file/$dir\//}
			done

			# echo '$file' "$file"
			mv -n "$1" "$dir/$file"
		done
	done

}

moveAllFilesOfDirectoryToAnotherDirectory() {
	# echo "$2"
	for file in "$1"/*; do
		# echo ${file/$1\//}
		# ? foo/1.txt => 1.txt
		# file=${file/$1\//}
		# echo "$file"
		moveSingleFileToDirectory "$file" "$2"
	done

	# echo "directory"

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
