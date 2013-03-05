#b main
b decode
b *0x80486b6
display /wx $eip
#display /d $ecx
#display /d $eax
#display /d $edx
display /32xw $esp
display /s $eax
display /f $eax
display /w (char*)$eax
display /s 0x8048a20
