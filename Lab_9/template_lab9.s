
.section .text
.global main



main:
    # Prepare jump to super mode
    li t1, 1
    slli t1, t1, 11   #mpp_mask
    csrs mstatus, t1
    
    la t4, supervisor       #load address of user-space code
    csrrw zero, mepc, t4    #set mepc to user code
    
    la t5, page_fault_handler
    csrw mtvec, t5
   
    mret

supervisor:
################## Setting up page tables ##############
    # Set value in PTE2 (Initial Mapping)
    li a0,0x81000000
    li a1, 0x82000
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 16(a0)

    # To set V.A 0x0 -> P.A 0x0
    li a1, 0x82001
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set value in PTE1 (Initial Mapping)
    li a0,0x82000000
    li a1, 0x83000
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set Frame number in PTE0 (Initial Mapping)
    li a0,0x83000000
    li a1, 0x80000
    slli a1, a1, 0xa
    ori a1, a1, 0xef # D | A | G | - | X | W | R |V
    sd a1, 0(a0)

    li a1, 0x80001
    slli a1, a1, 0xa
    ori a1, a1, 0xef # D | A | G | - | X | W | R |V
    sd a1, 8(a0)

    # Set value in PTE1 (Code Mapping)
    li a0,0x82001000
    li a1, 0x83001
    slli a1, a1, 0xa
    ori a1, a1, 0x01 # | - | - | - |V
    sd a1, 0(a0)

    # Set value in PTE0 (Code Mapping)
    li a0,0x83001000
    li a1, 0x80001
    slli a1, a1, 0xa
    ori a1, a1, 0xfb # D | A | G | U | X | - | R |V
    sd a1, 0(a0)

    # Data Mapping
    li a1, 0x80002
    slli a1, a1, 0xa
    ori a1, a1, 0xf7 # D | A | G | U | - | W | R |V
    sd a1, 8(a0)
    

####################################################################

    # Prepare jump to user mode
    li t1, 0
    slli t1, t1, 8   #spp_mask
    csrs sstatus, t1

    # Configure satp
    la t1, satp_config 
    ld t2, 0(t1)
    sfence.vma zero, zero
    csrrw zero, satp, t2
    sfence.vma zero, zero

    li t4, 0       # load VA address of user-space code
    csrrw zero, sepc, t4    # set sepc to user code
    
    sret



###################################################################
##################### ADD CODE ONLY HERE  #########################
###################################################################
.align 4
page_fault_handler:
    j pf_start
    
    .align 3
save_area:      .space 128
free_page:      .dword 0x80003000
free_l0_pt:     .dword 0x83002000

pf_start:
    csrw mscratch, t0
    la t0, save_area
    sd t1, 0(t0)
    sd t2, 8(t0)
    sd t3, 16(t0)
    sd t4, 24(t0)
    sd t5, 32(t0)
    sd t6, 40(t0)
    sd a0, 48(t0)
    sd a1, 56(t0)
    sd a2, 64(t0)
    csrr t1, mscratch
    sd t1, 72(t0)

    csrr t1, mcause
    li t2, 12
    beq t1, t2, handle_inst_pf
    li t2, 13
    beq t1, t2, handle_data_pf
    li t2, 15
    beq t1, t2, handle_data_pf

pf_end:
    la t0, save_area
    ld t1, 0(t0)
    ld t2, 8(t0)
    ld t3, 16(t0)
    ld t4, 24(t0)
    ld t5, 32(t0)
    ld t6, 40(t0)
    ld a0, 48(t0)
    ld a1, 56(t0)
    ld a2, 64(t0)
    ld t0, 72(t0)
    mret

handle_inst_pf:
    csrr t2, mtval
    srli t3, t2, 21         
    li t4, 0x1FF
    and t3, t3, t4

    li t4, 0x82001000
    slli t5, t3, 3
    add t4, t4, t5
    ld t5, 0(t4)
    andi t6, t5, 1
    bnez t6, inst_l1_valid

    la t6, free_l0_pt
    ld a0, 0(t6)
    li t0, 4096
    add a1, a0, t0
    sd a1, 0(t6)
    
    mv a1, a0
    li a2, 4096
clear_l0_inst:
    sd zero, 0(a1)
    addi a1, a1, 8
    addi a2, a2, -8
    bnez a2, clear_l0_inst

    srli a1, a0, 12
    slli a1, a1, 10
    ori a1, a1, 1
    sd a1, 0(t4)
    mv t5, a1

inst_l1_valid:
    srli t5, t5, 10
    slli t5, t5, 12
    
    csrr t2, mtval
    srli t3, t2, 12
    li t4, 0x1FF
    and t3, t3, t4
    slli t3, t3, 3          
    add t4, t5, t3

    la t6, free_page
    ld a0, 0(t6)
    li t0, 4096
    add a1, a0, t0
    sd a1, 0(t6)

    li a1, 0x80001000
    mv a2, a0
    li t3, 4096
copy_code:
    ld t6, 0(a1)
    sd t6, 0(a2)
    addi a1, a1, 8
    addi a2, a2, 8
    addi t3, t3, -8
    bnez t3, copy_code

    srli a1, a0, 12
    slli a1, a1, 10
    ori a1, a1, 0xFB        
    sd a1, 0(t4)
    
    sfence.vma zero, zero
    j pf_end

handle_data_pf:
    csrr t2, mtval
    srli t3, t2, 21
    li t4, 0x1FF
    and t3, t3, t4

    li t4, 0x82001000
    slli t5, t3, 3          
    add t4, t4, t5          
    ld t5, 0(t4)            
    andi t6, t5, 1          
    bnez t6, data_l1_valid

    la t6, free_l0_pt
    ld a0, 0(t6)
    li t0, 4096
    add a1, a0, t0
    sd a1, 0(t6)
    
    mv a1, a0
    li a2, 4096
clear_l0_data:
    sd zero, 0(a1)
    addi a1, a1, 8
    addi a2, a2, -8
    bnez a2, clear_l0_data

    srli a1, a0, 12         
    slli a1, a1, 10         
    ori a1, a1, 1           
    sd a1, 0(t4)            
    mv t5, a1               

data_l1_valid:
    srli t5, t5, 10
    slli t5, t5, 12
    
    csrr t2, mtval
    srli t3, t2, 12
    li t4, 0x1FF
    and t3, t3, t4
    slli t3, t3, 3          
    add t4, t5, t3

    li a0, 0x80002000
    srli a1, a0, 12
    slli a1, a1, 10
    ori a1, a1, 0xF7        
    sd a1, 0(t4)

    sfence.vma zero, zero
    j pf_end
###################################################################
###################################################################



.align 12
user_code:
    la t1,var_count
    lw t2, 0(t1)
    addi t2, t2, 1
    sw t2, 0(t1)

    la t5, code_jump_position
    lw t3, 0(t5)
    li t4, 0x2000
    add t3, t3, t4
    sw t3, 0(t5)
    
    jalr x0, t3


.data
.align 12
var_count:  .word  0
code_jump_position: .word 0x0000


.align 8
# Value to set in satp
satp_config: .dword 0x8000000000081000
