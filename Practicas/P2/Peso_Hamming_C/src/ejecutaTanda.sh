#!/bin/bash

for ((i=0 ; i<11; i++))
do
	echo $i
	./$1
done | pr -11 -l 20 -w 130
