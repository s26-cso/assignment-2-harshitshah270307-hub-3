.equ NODE_SIZE,   24
.equ VAL_OFF,     0
.equ LEFT_OFF,    8
.equ RIGHT_OFF,   16

.text
.globl make_node
make_node:
    addi sp, sp, -16
    sd   ra, 8(sp)
    sd   s1, 0(sp)

    mv   s1, a0          
    li   a0, NODE_SIZE
    call malloc

    sw   s1, VAL_OFF(a0)
    sd   zero, LEFT_OFF(a0)
    sd   zero, RIGHT_OFF(a0)
    ld   s1, 0(sp)
    ld   ra, 8(sp)
    addi sp, sp, 16
    ret

.globl insert
insert:
    addi sp, sp, -32
    sd   ra, 24(sp)
    sd   s0, 16(sp)
    sd   s1, 8(sp)
    sd   s2, 0(sp)
    mv   s0, a0      
    mv   s1, a1      
    beqz s0, make_new
    lw   s2, VAL_OFF(s0)
    blt  s1, s2, go_left
    beq  s1, s2, same_val

go_right:
    ld   a0, RIGHT_OFF(s0)
    mv   a1, s1
    call insert
    sd   a0, RIGHT_OFF(s0)
    mv   a0, s0
    j    done_insert

go_left:
    ld   a0, LEFT_OFF(s0)
    mv   a1, s1
    call insert
    sd   a0, LEFT_OFF(s0)
    mv   a0, s0
    j    done_insert

same_val:
    mv   a0, s0
    j    done_insert
make_new:
    mv   a0, s1
    call make_node

done_insert:
    ld   s2, 0(sp)
    ld   s1, 8(sp)
    ld   s0, 16(sp)
    ld   ra, 24(sp)
    addi sp, sp, 32
    ret

.globl get
get:
loop_get:
    beqz a0, end_get
    lw   t0, VAL_OFF(a0)
    beq  a1, t0, end_get
    blt  a1, t0, left_get
    ld   a0, RIGHT_OFF(a0)
    j    loop_get

left_get:
    ld   a0, LEFT_OFF(a0)
    j    loop_get
end_get:
    ret

.globl getAtMost
getAtMost:
    li   t0, -1 
    mv   t1, a0      
    mv   t2, a1       

loop_am:
    beqz t2, end_am
    lw   t3, VAL_OFF(t2)
    blt  t1, t3, go_left_am
    mv   t0, t3
    ld   t2, RIGHT_OFF(t2)
    j    loop_am

go_left_am:
    ld   t2, LEFT_OFF(t2)
    j    loop_am

end_am:
    mv   a0, t0
    ret
