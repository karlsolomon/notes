   1              		.file	"a.c"
   2              		.option nopic
   3              		.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0_zmmul1p0_zaamo1p0_zalrsc1
   4              		.attribute unaligned_access, 0
   5              		.attribute stack_align, 16
   6              		.text
   7              	.Ltext0:
   8              		.file 0 "/home/ksolomon" "a.c"
   9              		.align	1
  10              		.globl	main
  12              	main:
  13              	.LFB0:
  14              		.file 1 "a.c"
   1:a.c           **** // #include <stdio.h>
   2:a.c           **** int main() {
  15              		.loc 1 2 12
  16 0000 10000000 		.cfi_startproc
  16      00000000 
  16      037A5200 
  16      017C0101 
  16      1B0C0200 
  17 0000 4111     		addi	sp,sp,-16
  18 0025 420E10   		.cfi_def_cfa_offset 16
  19 0002 06E4     		sd	ra,8(sp)
  20 0004 22E0     		sd	s0,0(sp)
  21 0028 448102   		.cfi_offset 1, -8
  22 002b 8804     		.cfi_offset 8, -16
  23 0006 0008     		addi	s0,sp,16
  24 002d 420C0800 		.cfi_def_cfa 8, 0
   3:a.c           ****     // printf("Hello, World!\n");
   4:a.c           ****     return 0;
  25              		.loc 1 4 12
  26 0008 8147     		li	a5,0
   5:a.c           **** }
  27              		.loc 1 5 1
  28 000a 3E85     		mv	a0,a5
  29 000c A260     		ld	ra,8(sp)
  30 0031 46C1     		.cfi_restore 1
  31 000e 0264     		ld	s0,0(sp)
  32 0033 42C8     		.cfi_restore 8
  33 0035 0C0210   		.cfi_def_cfa 2, 16
  34 0010 4101     		addi	sp,sp,16
  35 0038 420E00   		.cfi_def_cfa_offset 0
  36 0012 8280     		jr	ra
  37 003b 00000000 		.cfi_endproc
  37      00
  38              	.LFE0:
  40              	.Letext0:
