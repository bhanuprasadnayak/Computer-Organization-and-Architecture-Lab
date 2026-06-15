.data
arr: .word 5, 2, 9, 1, 3, 6
n:   .word 6

.text
.globl main

main:
    lw s0, n            
    addi s0, s0, -1    
    addi s1, zero, 0    

outer_loop:
    beq s1, s0, copy_sorted   

    addi s2, zero, 0         

inner_loop:
    lw t0, n
    sub t1, t0, s1            
    addi t1, t1, -1          
    beq s2, t1, next_i

    # arr[j]
    la t2, arr
    slli t3, s2, 2
    add t3, t3, t2
    lw t4, 0(t3)

    addi t5, t3, 4
    lw t6, 0(t5)

    blt t4, t6, no_swap

    # swap
    sw t6, 0(t3)
    sw t4, 0(t5)

no_swap:
    addi s2, s2, 1
    j inner_loop

next_i:
    addi s1, s1, 1
    j outer_loop

copy_sorted:
    addi s3, zero, 0   

copy_loop:
    lw t0, n
    beq s3, t0, exit  

    la t1, arr
    slli t2, s3, 2
    add t1, t1, t2
    lw t4, 0(t1)            

    sw t4, 0(t1)

    addi s3, s3, 1
    j copy_loop

exit:
    li a7, 93
    ecall