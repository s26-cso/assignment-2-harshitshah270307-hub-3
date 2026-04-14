.section .data
filename: .asciz "input.txt"
yesmsg:   .asciz "Yes\n"
nomsg:    .asciz "No\n"

.section .bss
leftch:   .skip 1
rightch:  .skip 1

.section .text
.globl _start

_start:
    li      a0, -100
    la      a1, filename
    li      a2, 0
    li      a3, 0
    li      a7, 56
    ecall
    mv      s0, a0

    bltz    s0, print_no

    mv      a0, s0
    li      a1, 0
    li      a2, 2
    li      a7, 62
    ecall
    mv      s1, a0

    li      s2, 0
    addi    s3, s1, -1

loop:
    bge     s2, s3, print_yes

    mv      a0, s0
    mv      a1, s2
    li      a2, 0
    li      a7, 62
    ecall

    mv      a0, s0
    la      a1, leftch
    li      a2, 1
    li      a7, 63
    ecall

    mv      a0, s0
    mv      a1, s3
    li      a2, 0
    li      a7, 62
    ecall

    mv      a0, s0
    la      a1, rightch
    li      a2, 1
    li      a7, 63
    ecall

    la      t0, leftch
    lb      t1, 0(t0)
    la      t0, rightch
    lb      t2, 0(t0)

    bne     t1, t2, print_no

    addi    s2, s2, 1
    addi    s3, s3, -1
    j       loop

print_yes:
    mv      a0, s0
    li      a7, 57
    ecall

    li      a0, 1
    la      a1, yesmsg
    li      a2, 4
    li      a7, 64
    ecall
    j       exit_program

print_no:
    bltz    s0, skip_close_no
    mv      a0, s0
    li      a7, 57
    ecall

skip_close_no:
    li      a0, 1
    la      a1, nomsg
    li      a2, 3
    li      a7, 64
    ecall

exit_program:
    li      a0, 0
    li      a7, 93
    ecall
    
