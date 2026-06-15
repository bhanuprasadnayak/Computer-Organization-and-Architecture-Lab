 .data
array:  .word 10, 10, 10, 10, 10
length: .word 5

    .text
    .globl main
main:
    la t0, array
    li t1, 0

loop:

    li t2, 5         # length = 5
    beq t1, t2, end

    slli t3, t1, 2   # offset = i * 4
    add t4, t0, t3   # t4 = address of array[i]
    lw t5, 0(t4)     # t5 = array[i]

    # Check if index is even or odd
    andi t6, t1, 1   # t6 = i & 1
    beq t6, zero, even_case

    odd_case:
    addi t5, t5, -1  # subtract 1
    sw t5, 0(t4)
    j next

even_case:
    addi t5, t5, 1   # add 1
    sw t5, 0(t4)

next:
    addi t1, t1, 1   # i++
    j loop

end:
    li a7, 93
    ecall