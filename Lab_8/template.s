.section .text
.global main

main:
    # 1. Setup PMP (Physical Memory Protection)
    li t0, 0x0F          # PMP_R | PMP_W | PMP_X | PMP_NAPOT
    csrw pmpcfg0, t0
    li t0, -1
    csrw pmpaddr0, t0

    # 2. Switch from Machine Mode to Supervisor Mode
    li t0, (1 << 11)     # Set MPP = 1 (Supervisor Mode)
    csrw mstatus, t0
    la t0, supervisor       
    csrw mepc, t0           
    mret                 

.align 12                
supervisor: 
    # Initialize L3 Table (VPN[3])
    la s0, l3_table
    la s1, l2_table
    srli s2, s1, 2
    ori  s2, s2, 0x1
    sd s2, 0(s0)

    # Initialize L2 Table (VPN[2])
    la s0, l2_table
    la s1, l1_user
    srli s2, s1, 2
    ori  s2, s2, 0x1
    sd s2, 0(s0)
    
    la s1, l1_sup
    srli s2, s1, 2
    ori  s2, s2, 0x1
    sd s2, 16(s0)

    # Initialize L1 Table User (VPN[1] = 0)
    la s0, l1_user
    la s1, l0_user
    srli s2, s1, 2
    ori  s2, s2, 0x1
    sd s2, 0(s0)

    # Initialize L1 Table Supervisor (VPN[1] = 472 for 0xBB...)
    la s0, l1_sup
    la s1, l0_sup
    srli s2, s1, 2
    ori  s2, s2, 0x1
    li t0, 472
    slli t0, t0, 3
    add t1, s0, t0
    sd s2, 0(t1)

    # Initialize L0 Table User (Leaf nodes)
    la s0, l0_user
    # User Code at Virtual 0x0
    la s1, user_code
    srli s2, s1, 2
    ori  s2, s2, 0xDF 
    sd s2, 0(s0) 
    # User Data at Virtual 0x1000
    la s1, user_data
    srli s2, s1, 2
    ori  s2, s2, 0xDF
    sd s2, 8(s0)

    # Initialize L0 Table Supervisor (Identity Mapping 0xBB000000)
    la s0, l0_sup
    la s1, main          # Physical start of supervisor space
    srli s2, s1, 2
    ori  s2, s2, 0xCF
    li t0, 8
map_sup:
    sd s2, 0(s0)
    addi s2, s2, 1024
    addi s0, s0, 8
    addi t0, t0, -1
    bnez t0, map_sup

    # Prepare for User Mode
    li t0, 0x100
    csrc sstatus, t0

    # Configure satp
    la t0, l3_table
    srli t0, t0, 12
    li t1, 0x9           # Sv48 Mode
    slli t1, t1, 60
    or t2, t1, t0
    la t1, satp_config
    sd t2, 0(t1)

################ DO NOT MODIFY THESE INSTRUCTIONS ################
    la t1, satp_config 
    ld t2, 0(t1)
    sfence.vma zero, zero
    csrrw zero, satp, t2
    sfence.vma zero, zero

    li t4, 0
    csrrw zero, sepc, t4
    sret
#################################################################### 

.align 12
user_code:
    # 1. Load variables into registers
    # We must use the mapped VIRTUAL address (0x1000), not the physical 'la' macro
    li t0, 0x1000        
    ld t1, 0(t0)         # var1
    ld t2, 8(t0)         # var2
    ld t3, 16(t0)        # var3
    ld t4, 24(t0)        # var4
loop:
    j loop

.align 12
user_data:
var1: .dword 1
var2: .dword 2
var3: .dword 3
var4: .dword 4

.align 12
# Page Table Storage Space
l3_table: .zero 4096
l2_table: .zero 4096
l1_user:  .zero 4096
l1_sup:   .zero 4096
l0_user:  .zero 4096
l0_sup:   .zero 4096

satp_config: .dword 0
