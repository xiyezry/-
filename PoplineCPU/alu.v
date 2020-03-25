//运算器实现
`include "ctrl_encode_def.v"

module alu(A, B, ALUOp,C);
           
	input  signed [31:0] A, B;
	input         [3:0]  ALUOp;
	output signed [31:0] C;
   
	reg [31:0] C_temp2;

	assign C = C_temp2;   
	
	always @( * ) begin
	  case ( ALUOp )
		  `ALU_NOP:  C_temp2 = A;                          
		  `ALU_ADD: C_temp2 = A + B;
		  `ALU_SUB: C_temp2 = A - B;      		
		  `ALU_AND: C_temp2 = A & B;		
		  `ALU_OR: C_temp2 = A | B;
		  `ALU_SLT:  C_temp2 = (A < B) ? 32'd1 : 32'd0;    // SLT/SLTI
		  `ALU_SLTU: C_temp2 = ({1'b0, A} < {1'b0, B}) ? 32'd1 : 32'd0;
		  `ALU_ADDU: C_temp2 = A + B;
		  `ALU_SUBU: C_temp2 = A - B;
		  `ALU_LUI: C_temp2 = {B[15:0],16'b0};
		  `ALU_XOR: C_temp2 = A^B;
		  `ALU_NOR: C_temp2 = ~(A|B);
		  4'b1111: //ALU_SPADD
			C_temp2 = A + B;
		  default:   C_temp2 = A;                          // Undefined
	  endcase
	end // end always
endmodule
    
