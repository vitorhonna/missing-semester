# Save current directory to a file in /tmp
marco () {
	echo "Saving current directory: $(pwd)"
	echo $(pwd) > /tmp/marco-dir
}

# Change into saved directory
polo () {
	echo "Changing into directory: $(cat /tmp/marco-dir)"
	cd $(cat /tmp/marco-dir)
}
