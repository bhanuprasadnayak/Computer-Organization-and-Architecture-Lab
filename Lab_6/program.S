.section .text
.global main
main:
# Configure CSR registers (medeleg, mstatus, mepc, mtvec, stvec)
# Execute mret to initiate downward transition to User code
    li t0, 0x100
    csrs medeleg, t0
    la t0, ucode
    csrw mepc, t0
    li t0, 0x1800
    csrc mstatus, t0
    la t0, mtrap_handler
    csrw mtvec, t0
    la t0, strap_handler
    csrw stvec, t0
    li a0, 0
    mret

    .align 4
mtrap_handler:
# Process traps originating from the strap_handler
# Perform the multiplication operation
# Flip a0 to 0
# Set mepc back to strap_handler and execute mret
    csrr t6, mstatus
    mul a1, a1, a2
    li a0, 0
    li t0, 0x1800
    csrc mstatus, t0
    li t0, 0x800
    csrs mstatus, t0
    la t0, strap_handler
    csrw mepc, t0
    mret

scode:
# Execute sret to initiate transition to User mode after setting the CSRs
    li t0, 0x100
    csrc sstatus, t0
    la t0, ucode1
    csrw sepc, t0
    sret

    .align 4
strap_handler:
# The Dispatcher
# Check if a0 == 0 or a0 == 1
# If a0 == 0: jump to scode (to setup S to U transition)
# If a0 == 1: execute ecall to jump up to mtrap_handler
    csrr t6, sstatus
    beqz a0, scode
    ecall

ucode:
# Note: Handle initial variable loading here if using a single User block
    li a1, 5
    li a2, 4
    ecall

ucode1:
# Perform the addition operation
# Flip a0 to 1
# The ecall should invoke the supervisor’s trap handler
    add a1, a1, a2
    li a0, 1
    ecall