.data
A: .word 15
B: .word 10
result: .word 0
result0: .word 0
result1: .word 0
result2: .word 0
result3: .word 0

.text
    .global main

main:

    la t0, A
    lw t1, 0(t0)

    la t0, B
    lw t2, 0(t0)

    add a1, t1, t2
    sub a2, t1, t2
    and a3, t1, t2
    or  a4, t1, t2
    not t3, t1
    xor a5, t3, t2

    la t0, result
    sw a1, 0(t0)
    sw a2, 4(t0)
    sw a3, 8(t0)
    sw a4, 12(t0)
    sw a5, 16(t0)


    li a7, 93
    ecall