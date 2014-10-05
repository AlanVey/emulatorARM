mov r2,#10
ldr r0,=0x20200000
mov r1,#1
lsl r1,#18
str r1,[r0,#40]
loop:
str r1,[r0,#40]
sub r2,r2,#1
cmp r2,#0
str r1,[r0,#28]
bne loop
andeq r0,r0,r0
