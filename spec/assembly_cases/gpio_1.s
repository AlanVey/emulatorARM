
ldr r0,=0x20200000
mov r1,#1
lsl r1,#6

str r1,[r0,#8]

mov r1,#1
lsl r1,#22

str r1,[r0,#40]

sub r2,r2,#1

str r1,[r0,#28]

andeq r0,r0,r0
