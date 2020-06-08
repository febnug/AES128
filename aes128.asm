; AES-128 asm
;
;
; compile dengan :
;
; x86 :
; nasm -f elf aes128.asm
; ld -o aes128 aes128.o --omagic
;
; note : CPU 32-bit ga support aes, jadi bakalan segfault, solusinya harus install OS 64-bit pake qemu
;
; x86_64 :
; nasm -f elf64 aes128.asm
; ld -N -s -m elf_x86_64 -o aes128 aes128.o --omagic

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
mov     byte [loc_7cb9+5], ah  

loc_7cb9:
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
