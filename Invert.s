# This program results from the compilation of Invert.c

# global array a
    .data
a: .word 468, 665, 922, 581, 401, 199, 213, 853, 782, 158

# invierte function
# kind: recursive function
# convention: a0 <-> a, a1 <-> div, a2 <-> x, t0 <-> resul, 
#   t1 and tp holds auxiliar values
# frame size:
#       -4 to back ra and fp up
#       -4 to back local variable resul up
#       -4 to back a0 up
# access-memory policy: load and store when needed
# returned value: a0 holds a
    .text
    .globl invierte
invierte:
    addi    sp, sp, -48             # update sp
    sw      ra, 48(sp)              # back ra up
    sw      fp, 44(sp)              # back fp up
    addi    fp, sp, 48              # update fp
    li      tp, 10                  # tp = 10
    div     tp, a1, tp              # tp = div / 10
    li      t1, 1                   # t1 = 1
    blt     tp, t1, L1              # if (div/10) < 1 then L1
    div     t0, a0, a1              # t0 = a / div
    sw      t0, -16(fp)             # resul = a / div
    lw      t0, -16(fp)             # t0 = resul
    mul     tp, t0, a1              # tp = resul * div
    sub     t1, a0, tp              # a = a - (resul * div)
    #   Inicia llamado recursivo
    sw      a0, -32(fp)             # backs a0 up
    sw      a1, -36(fp)             # backs a1 up
    sw      a2, -40(fp)             # backs a2 up
    mv      a0, t1                  # a0 = a
    li      tp, 10                  # tp = 10
    div     a1, a1, tp              # a1 = div / 10
    li      tp, 10                  # tp = 10
    mul     a2, a2, tp              # a2 = x * 10
    jal     invierte                # calls invierte
    mv      t1, a0                  # a = invierte(a, div/10, x*10)
    lw      a0, -32(fp)             # restores a0
    lw      a1, -36(fp)             # restores a1
    lw      a2, -40(fp)             # restores a2
    j       L2                      # jump to L2
L1: mv      t0, a0                  # t0 = a
    sw      t0, -16(fp)             # resul = a
    li      t1, 0                   # a = 0 
L2: lw      t0, -16(fp)             # t0 = resul
    mul     tp, t0, a2              # tp = resul * x
    add     t1, tp, t1              # a = (resul*x) + a
    mv      a0, t1                  # a0 = a
    # Liberacion del frame de inv
    lw      ra, 48(sp)              # restores ra
    lw      fp, 44(sp)              # restores fp
    addi    sp, sp, 48              # frees invierte frame
    jr      ra                      # return control to caller

# inv function
# kind: nesting function
# convention: a0 <-> *a, a1 <-> n, t0 <-> divisor, t1 <-> i 
#   t2 <-> *a, t3 <-> r and tp hold auxiliar values
# frame size:  
#       -4 to back ra and fp up
#       -4 to back local variables divisor, i and r up
#       -4 to back a0, a1 and a2 up
# access-memory policy: load when needed store after update
# returned value: none
    .globl inv
inv:
    addi    sp, sp, -48             # update sp
    sw      ra, 48(sp)              # back ra up
    sw      fp, 44(sp)              # back fp up
    addi    fp, sp, 48              # update fp
    li      t0, 100                 # t0 = 100
    sw      t0, -16(fp)             # divisor = 100
    # Entrada al bucle for
    li      t1, 0                   # t1 = 0
    sw      t1, -20(fp)             # i = 0
    lw      t1, -20(fp)             # t1 = i
M1: bge     t1, a1, M2              # if i >= n then L2
    sw      a1, -32(fp)             # backs a1 up 
    sw      a2, -36(fp)             # backs a2 up
    sw      a0, -40(fp)             # backs a0 up
    slli    tp, t1, 2               # tp = 4 * i
    add     t2, a0, tp              # t2 = address(a) + 4*i
    lw      a0, 0(t2)               # a0 = a[i]
    lw      t0, -16(fp)             # t0 = divisor
    mv      a1, t0                  # a1 = divisor
    li      a2, 1                   # a2 = 1
    jal     invierte                # calls invierte
    sw      a0, -24(fp)             # r = invierte(a[i], divisor, 1)
    lw      a1, -32(fp)             # restores a1
    lw      a2, -36(fp)             # restores a2
    lw      a0, -40(fp)             # restores a0
    lw      t3, -24(fp)             # t3 = r
    sw      t3, 0(t2)               # a[i] = r
    lw      t1, -20(fp)             # t1 = i
    addi    t1, t1, 1               # t1 = i++
    sw      t1, -20(fp)             # i++
    j       M1                      # jump to L1
M2: lw      ra, 48(sp)              # restores ra
    lw      fp, 44(sp)              # restores fp
    addi    sp, sp, 48              # frees inv frame
    jr      ra                      # return control to main

# main function
# kind: nested function
# convention: tp holds auxiliar values
# frame size: 16 bytes
#       -4  words to back ra and fp up
# access-memory policy: load when needed store after update
# returned value: a0 holds 0
    .globl main
main:
    addi    sp, sp, -16         # updates sp
    sw      ra, 16(sp)          # backs up ra
    sw      fp, 12(sp)          # backs up fp
    addi    fp, sp, 16          # updates fp
    # call inv
    li      a1, 10              # a1 = 10
    mv      a0, gp              # a0 = *a
    jal     inv                 # calls inv
    # return control to OS
    li      a0, 0               # a0 = 0
    lw      ra, 16(sp)          # restores ra
    lw      fp, 12(sp)          # restores fp
    addi    sp, sp, 12          # frees main's frame
    jr      ra                  # ends program ejecution