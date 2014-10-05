mov r2,#2
mov r0,#1
mov r1,#99
str r1,[r0,#3]
wait2:
sub r2,r2,#1
cmp r2,#0
str r1,[r0,#8]
bne wait2
