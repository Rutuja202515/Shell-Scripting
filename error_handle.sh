#!/bin/bash

#function definition

create_directory() {
	mkdir demo
}

#calling Function


if ! create_directory;
then
	echo "The code is being exited as directory is already exist."
	exit 1
fi

echo "directory has been created ! "
