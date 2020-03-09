//符号拓展器 op为1，符号拓展 op为0，0拓展
module EXT( Imm16, EXTOp, Imm32 );
    
   input  [15:0] Imm16;
   input         EXTOp;
   output [31:0] Imm32;
   
   assign Imm32 = (EXTOp) ? {{16{Imm16[15]}}, Imm16} : {16'd0, Imm16}; // signed-extension符号拓展 or zero extension零拓展
       
endmodule

module EXT_8( Imm8, EXTOp, Imm32 );
    
   input  [7:0] Imm8;
   input         EXTOp;
   output [31:0] Imm32;
   
   assign Imm32 = (EXTOp) ? {{24{Imm8[7]}}, Imm8} : {24'd0, Imm8}; // signed-extension符号拓展 or zero extension零拓展
       
endmodule