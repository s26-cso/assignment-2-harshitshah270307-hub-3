.equ NODE_SIZE,  24
.equ VAL_OFF,    0
.equ LEFT_OFF,   8
.equ RIGHT_OFF,  16

.text

.globl make_node
make_node:
    addi  sp, sp, -16
    sd    ra, 8(sp)
    sd    s0, 0(sp)

    mv    s0, a0

    li    a0, NODE_SIZE
    call  malloc

    sw    s0, VAL_OFF(a0)
    sd    zero, LEFT_OFF(a0)
    sd    zero, RIGHT_OFF(a0)

    ld    ra, 8(sp)
    ld    s0, 0(sp)
    addi  sp, sp, 16
    ret

.globl insert
insert:
    addi  sp, sp, -32
    sd    ra,  24(sp)
    sd    s0,  16(sp)
    sd    s1,   8(sp)
    sd    s2,   0(sp)

    mv    s0, a0
    mv    s1, a1

    bnez  s0, insert_non_null
    mv    a0, s1
    call  make_node
    j     insert_done

insert_non_null:
    lw    s2, VAL_OFF(s0)

    bge   s1, s2, insert_right_check

    ld    a0, LEFT_OFF(s0)
    mv    a1, s1
    call  insert
    sd    a0, LEFT_OFF(s0)
    mv    a0, s0
    j     insert_done

insert_right_check:
    beq   s1, s2, insert_equal

    ld    a0, RIGHT_OFF(s0)
    mv    a1, s1
    call  insert
    sd    a0, RIGHT_OFF(s0)
    mv    a0, s0
    j     insert_done

insert_equal:
    mv    a0, s0

insert_done:
    ld    ra,  24(sp)
    ld    s0,  16(sp)
    ld    s1,   8(sp)
    ld    s2,   0(sp)
    addi  sp, sp, 32
    ret

.globl get
get:
get_loop:
    beqz  a0, get_done

    lw    t0, VAL_OFF(a0)
    beq   a1, t0, get_done

    blt   a1, t0, get_go_left
    ld    a0, RIGHT_OFF(a0)
    j     get_loop
get_go_left:
    ld    a0, LEFT_OFF(a0)
    j     get_loop

get_done:
    ret

.globl getAtMost
getAtMost:
    li    t0, -1
    mv    t1, a1
    mv    t2, a0

getAtMost_loop:
    beqz  t1, getAtMost_done

    lw    t3, VAL_OFF(t1)

    bgt   t3, t2, getAtMost_go_left

    mv    t0, t3
    ld    t1, RIGHT_OFF(t1)
    j     getAtMost_loop

getAtMost_go_left:
    ld    t1, LEFT_OFF(t1)
    j     getAtMost_loop

getAtMost_done:
    mv    a0, t0
    ret
    
