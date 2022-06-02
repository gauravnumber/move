main() {
	# echo "$1"
	file="$1"
	dir="$2"
	# file=1.txt
	# temp=1.txt

	# If given file not exist then
	# Program end
	if [[ ! -e "$file" ]]; then
		echo "$file not exist"
		exit 1
	fi

	# File not exist in destination
	# So created
	if [[ ! -e "$dir/$file" ]]; then
		# echo "hile"
		mv -n "$file" "$dir/$file"
		exit 0
	fi

	index=1

	# echo "$dir"/*

	for i in "$dir"/*; do
		# echo '$i' "$i"
		# echo '$dir/$file' "$dir/$file"
		# echo ''

		newfileName=$file
		# echo "$newfileName"
		# if [[ "$i" == "$dir/$newfileName" || -n "$dir/$newfileName" | sed -E 's|(\w+)_([0-9]+)\.(\w+)|\2|g' ]]; then
		# if [[ "$i" == "$dir/$newfileName" ]]; then
		# echo "$dir/$newfileName"
		while [[ "$i" == "$dir/$newfileName" ]]; do
			# echo -e "\t$i" | sed -E "s|(\w+)\.(\w+)|\1_$index\.\2|g;"

			newfileName=$(echo "$i" | sed -E "s|(\w+)\.(\w+)|\1_$index\.\2|g;")
			newfileName=${newfileName/$dir\//}

			# echo "$newfileName"
			# echo "$dir"
			# exit 1

			# if [[ -e "$dir/$newfileName" ]]; then
			while [[ -e "$dir/$newfileName" ]]; do
				index=$(($index + 1))
				newfileName=$(echo "$i" | sed -E "s|(\w+)\.(\w+)|\1_$index\.\2|g;")
				newfileName=${newfileName/$dir\//}

				# echo -e '\t\t$newfileName' "$newfileName"
				# mv -n "$1" "$newfileName"
				# echo "hi"
				# else
				# mv -n "$1" "$newfileName"
				# echo "hello"
			done
			# fi
			# newfileName=${newfileName/$dir\//}

			# echo -e '\t$index' "$index"
			# echo -e '\t$newfileName' "$newfileName"
			mv -n "$1" "$dir/$newfileName"

			# echo -e '\t$dir/$newfileName' "$dir/$newfileName"
			# echo "$dir/$file"

			# echo $file
			# echo $i
		done
		# fi

		# file=temp
		# if [[ "$i" == "$dir/$file" ]]; then
		# 	echo "$i" | sed -E 's|(\w+)\.(\w+)|\1_1\.\2|g;'
		# fi
		# echo $i
	done
}

main "$@"
