.section .text.init
.global _start
_start:
    # 1. Initialize Stack Pointer (sp)
    la sp, _stack_top
    # 2. Setup Trap Vectors (mtvec)
    la t0, mtrap_handler
    csrw mtvec, t0
    # 3. Prepare transition to User Mode (mstatus and mepc)
    la t0, ucode
    csrw mepc, t0

    li t0, 0x1800
    csrc mstatus, t0
    # 4. Execute mret to jump to ucode
    mret
    .section .text
    .align 4
mtrap_handler:
    # --- Context Saving ---
    addi sp, sp, -80
    # Save registers used in ucode. In the ideal case should save all registers.
    sd t0, 0(sp)
    sd t1, 8(sp)
    sd t2, 16(sp)
    sd t3, 24(sp)
    sd t4, 32(sp)
    sd t5, 40(sp)
    sd t6, 48(sp)
    sd a0, 56(sp)
    sd a1, 64(sp)
    sd a2, 72(sp)
    # --- Decode mcause ---
    csrr t0, mcause
    csrr t1, mepc
    csrr t2, mtval

    # Implement logic to handle causes 2, 3, 4, 5, 8
    #Illegal Instruction
    li t3, 2
    beq t0, t3, handle_illegal
    #Breakpoint
    li t3, 3
    beq t0, t3, handle_break
    #Load Misaligned
    li t3, 4
    beq t0, t3, handle_misaligned
    #Load Access Fault
    li t3, 5
    beq t0, t3, handle_access
    #U-mode Ecall
    li t3, 8
    beq t0, t3, handle_ecall

    j restore

handle_illegal:
    mv s9, t2
    addi t1, t1, 4
    csrw mepc, t1
    j restore

handle_break:
    li a0, 0xBEEF
    addi t1, t1, 2
    csrw mepc, t1
    j restore

handle_misaligned:
    mv s10, t2
    addi t1, t1, 4
    csrw mepc, t1
    j restore

handle_access:
    mv s11, t2
    addi t1, t1, 4
    csrw mepc, t1
    j restore

handle_ecall:
    li a0, 0xFEED
    addi t1, t1, 4
    csrw mepc, t1
    j restore

    # --- Context Restoration ---
restore:
    ld t0, 0(sp)
    ld t1, 8(sp)
    ld t2, 16(sp)
    ld t3, 24(sp)
    ld t4, 32(sp)
    ld t5, 40(sp)
    ld t6, 48(sp)
    ld a0, 56(sp)
    ld a1, 64(sp)
    ld a2, 72(sp)

    addi sp, sp, 80
    mret

ucode:
    # --- Sequence of Exception Tests ---
    # Trigger exceptions one after another to test your handler logic

    #Illegal Instruction
    .word 0x00000000
    #breakpoint
    ebreak
    #misaligned
    la t0, ucode
    ld t0, 0(t0)
    #access fault
    li t0, 0x0
    ld t1, 0(t0)
    #ecall
    ecall

    j .

.section .bss
.align 16
_stack_low:
.space 4096
_stack_top: