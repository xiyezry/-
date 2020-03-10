// NPC control signal
`define NPC_PLUS4   2'b00
`define NPC_BRANCH  2'b01
`define NPC_JUMP    2'b10
`define NPC_RS      2'b11


// ALU control signal
`define ALU_NOP   4'b0000 
`define ALU_ADD   4'b0001
`define ALU_SUB   4'b0010 
`define ALU_AND   4'b0011
`define ALU_OR    4'b0100
`define ALU_SLT   4'b0101
`define ALU_SLTU  4'b0110
`define ALU_ADDU  4'b0111
`define ALU_SUBU  4'b1000

`define ALU_LUI   4'b1100
`define ALU_XOR   4'b1101
`define ALU_NOR   4'b1110
`define ALU_SpADD 4'b1111

