mov r2,#0x3F0000
wait:
sub r2,r2,#1
cmp r2,#0xFF
bne wait
