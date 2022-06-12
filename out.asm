  .text
  .globl f1d
f1d:
  addi sp, sp, -48
.Lentry_0:

  mv t1,a0
  sw t1, 44(sp)

  j .Lbegin_0

.Lbegin_0:

  li t1,0
  sw t1, 40(sp)

  j .Lwhile_entry_1

.Lwhile_entry_1:
  lw t1, 40(sp)
  sw t1, 36(sp)

  lw t1, 36(sp)
  li t2,10
  slt t1, t1, t2
  sw t1, 32(sp)

  lw t1, 32(sp)
  bnez t1, .Lwhile_body_1
  j .Lwhile_end_1

.Lwhile_body_1:
  lw t1, 40(sp)
  sw t1, 28(sp)

  lw t1, 40(sp)
  sw t1, 24(sp)

  lw t1, 44(sp)
  sw t1, 20(sp)

  lw t1, 20(sp)
  lw t2, 24(sp)
  slli t2, t2, 2
  add  t1, t1, t2
  sw t1, 16(sp)

  lw t1, 28(sp)
  lw t2, 16(sp)
  sw t1, 0(t2)

  lw t1, 40(sp)
  sw t1, 12(sp)

  lw t1, 12(sp)
  li t2,1
  add t1, t1, t2
  sw t1, 8(sp)

  lw t1, 8(sp)
  sw t1, 40(sp)

  j .Lwhile_entry_1

.Lwhile_end_1:
  j .Lend_0

.Lend_0:
  addi sp, sp, 48
ret



  .text
  .globl f2d
f2d:
  addi sp, sp, -64
  sw ra, 60(sp)
.Lentry_1:

  mv t1,a0
  sw t1, 56(sp)

  j .Lbegin_1

.Lbegin_1:
  lw t1, 56(sp)
  sw t1, 52(sp)

  lw t1, 52(sp)
  li t2,1
  li t0, 40
 mul t2, t2, t0
  add  t1, t1, t2
  sw t1, 48(sp)

  lw t1, 48(sp)
  li t2,2
  slli t2, t2, 2
  add  t1, t1, t2
  sw t1, 44(sp)

  li t1,3
  lw t2, 44(sp)
  sw t1, 0(t2)


  li t1,0
  sw t1, 40(sp)

  j .Lwhile_entry_2

.Lwhile_entry_2:
  lw t1, 40(sp)
  sw t1, 36(sp)

  lw t1, 36(sp)
  li t2,10
  slt t1, t1, t2
  sw t1, 32(sp)

  lw t1, 32(sp)
  bnez t1, .Lwhile_body_2
  j .Lwhile_end_2

.Lwhile_body_2:
  lw t1, 40(sp)
  sw t1, 28(sp)

  lw t1, 56(sp)
  sw t1, 24(sp)

  lw t1, 24(sp)
  lw t2, 28(sp)
  li t0, 40
 mul t2, t2, t0
  add  t1, t1, t2
  sw t1, 20(sp)

  lw t1, 20(sp)
  li t2,0
  slli t2, t2, 2
  add  t1, t1, t2
  sw t1, 16(sp)

  lw t1, 16(sp)
  mv a0,t1
  call f1d

  lw t1, 40(sp)
  sw t1, 12(sp)

  lw t1, 12(sp)
  li t2,1
  add t1, t1, t2
  sw t1, 8(sp)

  lw t1, 8(sp)
  sw t1, 40(sp)

  j .Lwhile_entry_2

.Lwhile_end_2:
  j .Lend_1

.Lend_1:
  lw ra, 60(sp)
  addi sp, sp, 64
ret



  .text
  .globl main
main:
  addi sp, sp, -16
.Lentry_2:

  j .Lbegin_2

.Lbegin_2:
  li t1,33
  sw t1, 12(sp)

  j .Lend_2

.Lend_2:
  lw t1, 12(sp)
  sw t1, 8(sp)

  lw t1, 8(sp)
  move a0,t1
  addi sp, sp, 16
ret



