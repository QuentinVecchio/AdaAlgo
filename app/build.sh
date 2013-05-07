#!/bin/bash

if [ ! $1 ]
then
	echo "Veuillez spécifier un fichier !"
else
	gnatmake $1 -aIoutils
fi