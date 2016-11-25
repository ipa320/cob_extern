#!/bin/bash 
if [ "$QSOPT_INST" == "true" ]
   then
	cd $1 && echo "Qsopt: " && echo $2 && ./configure --with-qsopt=$2 && make
   else
	cd $1 && echo "no Qsopt" && ./configure && make
fi
