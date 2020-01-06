global _start
section .text

_start:

pxor    xmm2, xmm2
pxor    xmm3, xmm3
mov     bx, 0x36e5
mov     ah, 0x73

roundloop:
shr     ax, 7
div     bl
mov     byte [sdfsdf+5], ah

sdfsdf:
aeskeygenassist xmm1, xmm0, 0x45
pshufd  xmm1, xmm1, 0xff

shuffle:
shufps  xmm2, xmm0, 0x10
pxor    xmm0, xmm2
xor     byte [shuffle+3], 0x9c
js      short shuffle

pxor    xmm0, xmm1
cmp     ah, bh
jz      short lastround

aesenc  xmm3, xmm0
jmp     short roundloop

lastround:
aesenclast xmm3, xmm0
ret
