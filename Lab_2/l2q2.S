.data
matA: .word 1,2,3,4,5,6,7,8,9
matB: .word 9,8,7,6,5,4,3,2,1
result:.word 0,0,0,0,0,0,0,0,0
n: .word 3

.text
.global main

main:
    la t0,result
    la t5,matA
    la t6,matB
    lw t1,n
    li t2,0

loopi:
    beq t2,t1,end
    li t3,0
    j loopj
    loopjend:
    addi t2,t2,1
    j loopi

loopj:
    beq t3,t1,loopjend
    li t4,0
    mul a0,t1,t2
    add a0,a0,t3
    sll a0,a0,2
    add a0,a0,t0
    lw s0,0(a0)
    j loopt
    looptend:
    sw s0,0(a0)
    addi t3,t3,1
    j loopj

loopt:
    beq t4,t1,looptend
    mul a1,t1,t2
    add a1,a1,t4
    sll a1,a1,2
    add a1,a1,t5
    lw s1,0(a1)
    mul a2,t1,t4
    add a2,a2,t3
    sll a2,a2,2
    add a2,a2,t6
    lw s2,0(a2)
    mul s1,s1,s2
    add s0,s0,s1
    addi t4,t4,1
    j loopt

end:
    li a7,93
    ecall
