# Processor - [FASA](https://docs.google.com/document/d/1YYZlfPYRjftxfdg3hMG-gS3LckAowv40sSqFgsXgi-A/edit?usp=sharing)

FASA is a RISC microprocessor architect. We designed a ISA with the constraint of 9-bits instruction length. Therefore it comes with limited amount of Registers and Instructions. 

This was designed to run three specific programs. Detect 2-bit corructed message, Detect and correct 1-bit corruted message, and pattern seaching. FASA runs with 
four special register. r0 for memory operation(load and store), r1 and r2 for arithmetic operation, and r3 for load immediate operation. 

## Instruction format
* **R-Type**:  &nbsp;Any instruction that uses one or more registers as an input.
* **I-Type**:  &nbsp;loading 8-bit immediate values to a special register. </pre>

## R-type

| op | operation | rs/rt |
| :-: | :---: | :----: |
| 0 | _ _ _ _ | _ _ _ _|

### Operation
<pre>
0000 - ADD (add the values in r1 and r2 and store in rt)
0001 - XOR (bitwise XOR r1 and r2 and store in rt) 
0010 - ORR (bitwise OR r1 and r2 and store in rt)
0011 - LOD (load the value in mem[r0] and store in rt)
0100 - STR (store the value in rs to mem[r0])
0101 - BNE (if r1 not equals to r2 branch to start address+offset, if not stay)
0110 - SLL (Shift the contents in r1 to left r2 positions, store in rt)
0111 - SRL (Shift the contents in r1 to right r2 positions, store in rt)
1000 - AND (bitwise AND r1 and r2 and store in rt)
1001 - XXR (Reduction XOR r1+r2 and store result in 1 bit in rt)
1010 - CPP (Copy a value from another rs to r1)
1011 - CYY (Copy a value from another rs to r2)
1100 - SUB (r1 subtract r2 and store in rt)
1101 - BGT (if r1 is > r2 branch to start address+offset, if not stay)
1110 - EQL(if r1 == r2, rt = 1 else rt = 0).
</pre>

*Example*
```ruby
0 0010 1011 - r11 = r1 bitwise-or r2 .
0 1101 1010 - if r1 > r2, branch to start of current program address + r10.
0 0011 1001 - r9 = mem[r0] , load contents from memory location r0 to reg r9.
0 0100 1001 - mem[r0] = r9, store the contents in reg r9 to memory location r0.
0 1010 1000 - r1 = r8 , copy the values in r8 to r1.
0 1001 1001 - r1 = 00010001, r2 = 0001000, r9 = ^r1^r2.
0 1001 1100 - input string store in r1 and r2, calculate the parity bits for it.
0 0010 0011 - r3 = reduction XOR{r1 concat. r2}.

```

## I-type

| op | Immediate |
| :-: | :-------: |
| 1 | _ _ _ _ _ _ _ _|

###Example
<pre>
1 00001100 - load an immediate value 00001100 to special register $r3
1 11001100 - load an immediate value 11001100 to special register $r3
</pre>

## More
[FASA](https://docs.google.com/document/d/1YYZlfPYRjftxfdg3hMG-gS3LckAowv40sSqFgsXgi-A/edit?usp=sharing)
