#!/bin/bash

is_folder_exists() {
	if [ -d $1 ]; then
	   	return 0;
	else
		return 1;
	fi
}