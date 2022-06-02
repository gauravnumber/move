moveSingleFileToDirectory() {
	file="$1"
	dir="$2"

	# if [[ -d $file ]]; then echo "dire"; fi

	#? If destination file not exist then created
	# if [[ ! -e "$dir/$file" ]]; then
	# 	# echo "hie"
	# 	echo '$dir/$file' "$dir/$file"

	# 	mv -n "$file" "$dir/$file"
	# 	exit 0
	# fi

	index=1

	for destinationFile in "$dir"/*; do
		newfileName=$file
		#? rm src. dir name
		#? foo/1.txt => 1.txt
		newfileName=${newfileName/[a-z]*\//}
		# newfileName=${newfileName/$dir\//}

		# echo '$newfileName' "$newfileName"

		#? rm dest. dir name
		#? bar/1.txt => 1.txt
		destinationFile=${destinationFile/$dir\//}
		# echo '$destinationFile' "$destinationFile"
		# echo "$dir"/*
		# while [[ "$destinationFile" == "$dir/$newfileName" ]]; do
		while [[ "$destinationFile" == "$newfileName" ]]; do
			newfileName=$(echo "$destinationFile" | sed -E "s|(\w+)\.(\w+)|\1_$index\.\2|g;")
			# newfileName=${newfileName/$dir\//}
			# echo '$newfileName' "$newfileName"

			# while [[ -e "$newfileName" ]]; do
			while [[ -e "$dir/$newfileName" ]]; do
				index=$(($index + 1))
				newfileName=$(echo "$destinationFile" | sed -E "s|(\w+)\.(\w+)|\1_$index\.\2|g;")
				# newfileName=${newfileName/$dir\//}
			done

			# echo '$newfileName' "$newfileName"
			mv -n "$1" "$dir/$newfileName"
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
