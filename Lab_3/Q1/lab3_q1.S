.data
N: .word 345
result: .word 0

.text
.global main

main:
    lw a0, N
    jal ra, sumDigits

    la t0, result
    sw a0, 0(t0)

    li a7, 93
    ecall

sumDigits:
    addi sp, sp, -12
    sw ra, 8(sp)
    sw a0, 4(sp)
    sw s0, 0(sp)

    li t0, 10
    blt a0, t0, base_case

    rem s0, a0, t0

    div a0, a0, t0

    jal ra, sumDigits

    add a0, a0, s0
    j end_sum

base_case:
    j end_sum

end_sum:
    lw s0, 0(sp)
    lw ra, 8(sp)
    addi sp, sp, 12
    jalr x0, ra, 0