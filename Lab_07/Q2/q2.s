    .section .data
.global ans # need to declare as a global variable
ans: .space 40

.section .type
.global decrypt # need to declare as a global variable

decrypt:
    # perform decryption over the string cipher_text
    la t0, cipher_text
    la t1, substitution
    la t2, ans

    loop: 
    lb t3, 0(t0)
    beqz t3, done

    li t4, 0

search:
    add t5, t1, t4
    lb t6, 0(t5)

    beq t6, t3, found

    addi t4, t4, 1
    li a0, 26
    blt t4, a0, search

found:
    addi t4, t4, 'a'
    sb t4, 0(t2)

    addi t0, t0, 1
    addi t1, t1, 1

    j loop

done:
    sb zero, 0(t2)

    ret