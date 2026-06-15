// handler.c
#include <stdint.h>

struct process_table_struct{
    uint64_t pid;
    uint64_t state; // 0: not running, 1: running
    uint64_t program_counter;
    uint64_t stack_pointer;
};
extern volatile struct process_table_struct process_table[4];
extern void ucode_checker();
extern void ucode_counter();
extern void ucode_fib();
extern volatile uint64_t _stack_top; // Access &_stack_top to get the address 
extern volatile uint32_t current_process;

struct return_values {
    uint64_t program_counter;
    uint64_t stack_pointer;
};

struct return_values setup_processes() {

    uint64_t base_addr = (uint64_t)&_stack_top;
    uint64_t chunk_size = 1024;

    for (int idx = 0; idx < 4; idx++) {
        process_table[idx].state = 0;     // All processes start as not running
        process_table[idx].pid = idx + 1; // Assign PIDs starting from 1
        process_table[idx].stack_pointer = base_addr;
        base_addr = base_addr - chunk_size;
    }

    // Set stack pointer for each process. Chunk up the stack between _stack_top and _stack_low into equal parts.
    // Set the program counter for each process (0-1 run ucode_checker, 2 runs ucode_counter, 2 runs ucode_fib)
    
    process_table[0].program_counter = (uint64_t)ucode_checker;
    process_table[1].program_counter = (uint64_t)ucode_checker;
    process_table[2].program_counter = (uint64_t)ucode_counter;
    process_table[3].program_counter = (uint64_t)ucode_fib;

    // Set the first process as running and return its program counter and stack pointer

    process_table[0].state = 1;
    struct return_values out;
    out.program_counter = process_table[0].program_counter;
    out.stack_pointer = process_table[0].stack_pointer;

    return out;
}

struct return_values switch_processes(uint64_t mepc, uint64_t sp) {

    uint32_t curr_idx = current_process;

    // Save the program counter and stack pointer of the current process, mark it as not running
    process_table[curr_idx].stack_pointer = sp;
    process_table[curr_idx].program_counter = mepc;
    process_table[curr_idx].state = 0;

    // Round robin scheduling. (i + 1) % 4.
    curr_idx = (curr_idx + 1) % 4;
    process_table[curr_idx].state = 1;
    current_process = curr_idx;

    // Return the program counter and stack pointer of the next process to run.
    struct return_values out;
    out.stack_pointer = process_table[curr_idx].stack_pointer;
    out.program_counter = process_table[curr_idx].program_counter;
    return out;
}

extern uint32_t fib_array[11];

void fibonacci_helper(int n) {
    if (n == 0) {
        fib_array[0] = 0;
        return;
    }
    if (n == 1) {
        fib_array[1] = 1;
        return;
    }
    fibonacci_helper(n - 1);
    fibonacci_helper(n - 2);
    fib_array[n] = fib_array[n - 1] + fib_array[n - 2];
}
