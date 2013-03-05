#!/bin/bash

echo as --32 -g $1 -o `basename $1 .s`.o
as --32 -g $1 -o `basename $1 .s`.o
echo -m elf_i386 $1.o -o `basename $1 .s`
ld -m elf_i386 `basename $1 .s`.o -o `basename $1 .s`
echo Borrando archivos autogenerados...
rm `basename $1 .s`.o
