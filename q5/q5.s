.section .data
file: .asciz "input.txt"
y:    .asciz "Yes\n"
n:    .asciz "No\n"

.section .bss
c1:   .skip 1
c2:   .skip 1

.section .text
.globl _start

_start:
    li    a0, -100
    la    a1, file
    li    a2, 0
    li    a3, 0
    li    a7, 56
    ecall
    mv    s0, a0

    bltz  s0, no_out

    mv    a0, s0
    li    a1, 0
    li    a2, 2
    li    a7, 62
    ecall
    mv    s1, a0

    li    s2, 0
    addi  s3, s1, -1

l1:
    bge   s2, s3, yes_out

    mv    a0, s0
    mv    a1, s2
    li    a2, 0
    li    a7, 62
    ecall

    mv    a0, s0
    la    a1, c1
    li    a2, 1
    li    a7, 63
    ecall

    mv    a0, s0
    mv    a1, s3
    li    a2, 0
    li    a7, 62
    ecall

    mv    a0, s0
    la    a1, c2
    li    a2, 1
    li    a7, 63
    ecall

    la    t0, c1
    lb    t1, 0(t0)
    la    t0, c2
    lb    t2, 0(t0)

    beq   t1, t2, l2
    j     no_out

l2:
    addi  s2, s2, 1
    addi  s3, s3, -1
    j     l1

yes_out:
    mv    a0, s0
    li    a7, 57
    ecall

    li    a0, 1
    la    a1, y
    li    a2, 4
    li    a7, 64
    ecall
    j     done

no_out:
    bltz  s0, l3
    mv    a0, s0
    li    a7, 57
    ecall

l3:
    li    a0, 1
    la    a1, n
    li    a2, 3
    li    a7, 64
    ecall

done:
    li    a0, 0
    li    a7, 93
    ecall
    
