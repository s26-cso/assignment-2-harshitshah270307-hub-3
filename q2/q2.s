.data
fmt_int:    .string "%d"
fmt_space:  .string " "
fmt_nl:     .string "\n"

.text
.globl main
main:
    addi  sp, sp, -48
    sd    ra,  40(sp)
    sd    s0,  32(sp)
    sd    s1,  24(sp)
    sd    s2,  16(sp)
    sd    s3,   8(sp)
    sd    s4,   0(sp)

    addi  s0, a0, -1
    mv    t6, a1

    blez  s0, print_empty

    slli  a0, s0, 2
    call  malloc
    mv    s1, a0

    slli  a0, s0, 2
    call  malloc
    mv    s2, a0

    slli  a0, s0, 2
    call  malloc
    mv    s3, a0

    li    s4, -1

    li    t0, 0
parse_loop:
    bge   t0, s0, parse_done
    addi  t1, t0, 1
    slli  t1, t1, 3
    add   t1, t6, t1
    ld    a0, 0(t1)
    call  atoi
    slli  t1, t0, 2
    add   t1, s1, t1
    sw    a0, 0(t1)
    addi  t0, t0, 1
    j     parse_loop
parse_done:

    li    t0, 0
init_loop:
    bge   t0, s0, init_done
    slli  t1, t0, 2
    add   t1, s2, t1
    li    t2, -1
    sw    t2, 0(t1)
    addi  t0, t0, 1
    j     init_loop
init_done:

    addi  t0, s0, -1
algo_loop:
    bltz  t0, algo_done

    slli  t1, t0, 2
    add   t1, s1, t1
    lw    t2, 0(t1)

pop_loop:
    bltz  s4, pop_done
    slli  t3, s4, 2
    add   t3, s3, t3
    lw    t4, 0(t3)
    slli  t5, t4, 2
    add   t5, s1, t5
    lw    t5, 0(t5)
    bgt   t5, t2, pop_done
    addi  s4, s4, -1
    j     pop_loop
pop_done:

    bltz  s4, push_i
    slli  t3, s4, 2
    add   t3, s3, t3
    lw    t4, 0(t3)
    slli  t3, t0, 2
    add   t3, s2, t3
    sw    t4, 0(t3)

push_i:
    addi  s4, s4, 1
    slli  t3, s4, 2
    add   t3, s3, t3
    sw    t0, 0(t3)

    addi  t0, t0, -1
    j     algo_loop
algo_done:

    li    t0, 0
print_loop:
    bge   t0, s0, print_newline

    beqz  t0, skip_space
    la    a0, fmt_space
    call  printf
skip_space:

    slli  t1, t0, 2
    add   t1, s2, t1
    lw    a1, 0(t1)
    la    a0, fmt_int
    call  printf

    addi  t0, t0, 1
    j     print_loop

print_newline:
    la    a0, fmt_nl
    call  printf
    j     exit_prog

print_empty:
    la    a0, fmt_nl
    call  printf

exit_prog:
    li    a0, 0
    ld    ra,  40(sp)
    ld    s0,  32(sp)
    ld    s1,  24(sp)
    ld    s2,  16(sp)
    ld    s3,   8(sp)
    ld    s4,   0(sp)
    addi  sp, sp, 48
    ret
    
