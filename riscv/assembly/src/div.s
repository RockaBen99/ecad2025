.macro DEBUG_PRINT reg
csrw 0x800, \reg
.endm
	
.text
.global div              # Export the symbol 'div' so we can call it from other files
.type div, @function
div:
    addi sp, sp, -32     # Allocate stack space

    # store any callee-saved register you might overwrite
    sw   ra, 28(sp)      # Function calls would overwrite
    sw   s0, 24(sp)      # If t0-t6 is not enough, can use s0-s11 if I save and restore them
    # ...

    # do your work
    # example of printing inputs a0 and a1
    # DEBUG_PRINT a0
    # DEBUG_PRINT a1

    beqz a1, divzero
    blt a0, a1, divlt

    li t0, 0 # Q := 0
    li t1, 0 # R := 0

    # get initial value of i = n - 1
    li t2, 0 # i
    mv t3, a0
loop1:
    beqz t3, end1
    addi t2, t2, 1
    srli t3, t3, 1
    j loop1
end1:
    # i := n

loop2:
    addi t2, t2, -1 # i--
    bltz t2, end2
    slli t1, t1, 1 # R := R << 1
    # N(i)
    srl t3, a0, t2
    andi t3, t3, 1

    add t1, t1, t3 # R(0) := N(i)

    blt t1, a1, loop2 # if R >= D
    sub t1, t1, a1 # R := R - D
    # Q(i) := 1
    li t3, 1
    sll t3, t3, t2
    add t0, t0, t3
    j loop2
end2:
    mv a0, t0
    mv a1, t1
    j end

divzero:
    mv a1, a0
    li a0, 0
    j end

divlt:
    li a0, 0

end:
    # load every register you stored above
    lw   ra, 28(sp)
    lw   s0, 24(sp)
    # ...
    addi sp, sp, 32      # Free up stack space
    ret

