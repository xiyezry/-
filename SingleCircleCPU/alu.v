//运算器实现
`include "ctrl_encode_def.v"

module alu(A, B, ALUOp, C, Zero,Carry,Negative,Overflow,LastTwo);
           
	input  signed [31:0] A, B;
	input         [3:0]  ALUOp;
	output signed [31:0] C;
	output Zero;
	output Carry;
	output Negative;
	output Overflow;
	output [1:0]LastTwo;
   
	reg Zero_temp;
	reg Carry_temp;
	reg Negative_temp;
	reg Overflow_temp;
	reg [31:0] C_temp;
	reg [31:0] C_temp2;

	assign Zero = Zero_temp;
	assign Carry = Carry_temp;
	assign Negative = Negative_temp;
	assign Overflow = Overflow_temp;
	assign C = C_temp2;
	assign LastTwo = C_temp[1:0];
	
	wire [7:0] zero_flag;
	wire [7:0] carry_flag;
	wire [7:0] negative_flag;
	wire [7:0] overflow_flag;
	
       
	always @( * ) begin
	  case ( ALUOp )
		  `ALU_NOP:  C_temp2 = A;                          
		  
		  
		  `ALU_ADD:  
			begin
			C_temp2 = A + B;
			if( C_temp2[31] == 1 )
				Negative_temp = 1;
			else if( C_temp2[31] == 0 )
				Negative_temp = 0;
			Carry_temp=0;
			if ( A[31] & ~B[31]) Overflow_temp = 0; //A < 0, B >= 0, overflow = 0
			else if ( ~A[31] & B[31] )  Overflow_temp = 0; // A >= 0, B < 0, overflow = 0
			else if ( A[31] & B[31] & C_temp2[31] ) Overflow_temp = 0; // A < 0, B < 0, C < 0, overflow = 0
			else if ( ~A[31] & ~B[31] & ~C_temp2[31]) Overflow_temp = 0; // A >= 0, B >= 0, C >= 0, overflow = 0
			else begin
				Overflow_temp = 1;
				C_temp2 = 0;
				end
			if( C_temp2 == 0 )
				Zero_temp = 1;  
			else 
				Zero_temp = 0;
			end
		  `ALU_SUB:
			begin
			C_temp2 = A - B;      
			Carry_temp = 0;
			if ( A[31] & B[31]) Overflow_temp = 0; //A < 0, B < 0, overflow = 0
			else if ( ~A[31] & ~B[31] )  Overflow_temp= 0; //A >= 0, B >= 0, overflow = 0
			else if ( A[31] & ~B[31] & C_temp2[31] ) Overflow_temp = 0; //A < 0, B >= 0, R < 0, overflow = 0
			else if ( ~A[31] & B[31] & ~C_temp2[31] )  Overflow_temp = 0; //A >= 0, B < 0, R > 0, overflow = 0
			else begin
				Overflow_temp = 1;
				C_temp2 = 0;
			end
			if( C_temp2 == 0 )
				Zero_temp = 1;
			else 
				Zero_temp = 0;
			if( C_temp2[31] == 1 )
				Negative_temp = 1;
			else if( C_temp2[31] == 0 )
				Negative_temp = 0; 
			end
			
		  `ALU_AND:
			begin
			C_temp2 = A & B;
			if( C_temp2 == 0 )
                Zero_temp = 1;
            else 
                Zero_temp = 0;
            Carry_temp = 0;
            Overflow_temp = 0;
            if( C_temp2[31] == 1 )
               Negative_temp = 1;
            else if( C_temp2[31] == 0 )
               Negative_temp = 0;
		    end
		  `ALU_OR:
			begin
			C_temp2 = A | B;
			if( C_temp2 == 0 )
                Zero_temp=1;
            else 
                Zero_temp=0;
            Carry_temp=0;
            Overflow_temp=0;
            if( C_temp2[31] == 1 )
                Negative_temp = 1;
            else if( C_temp2[31] == 0 )
                Negative_temp=0;
			end  
			
		  `ALU_SLT:  C_temp2 = (A < B) ? 32'd1 : 32'd0;    // SLT/SLTI
		  
		  `ALU_SLTU: C_temp2 = ({1'b0, A} < {1'b0, B}) ? 32'd1 : 32'd0;
		  
		  `ALU_ADDU:
			begin
			C_temp2 = A + B;
			if( C_temp2 == 0 )
				Zero_temp = 1;
			else
				Zero_temp = 0;
			if ( C_temp2 < A || C_temp2 < B ) Carry_temp = 1;
			else Carry_temp = 0;                 
			Negative_temp = 0;
			Overflow_temp = 0;
			end
			
		  `ALU_SUBU:
		    begin
			C_temp2 = A - B;
			if( C_temp2 == 0 )
				Zero_temp = 1;
			else 
				Zero_temp = 0;
			if( A >= B )
				Carry_temp = 0;
			else
				Carry_temp = 1;
			Negative_temp = 0;
			Overflow_temp = 0;
			end
		  //`ALU_SRA:
		  //`ALU_SRL:
		  //`ALU_SLL:
		  `ALU_LUI:
			begin 
            C_temp2 = {B[15:0],16'b0};
            if (C_temp2 == 0 )
                Zero_temp = 1;
            else Zero_temp = 0;
            if (C_temp2[31])
                Negative_temp = 1;
            else Negative_temp = 0;
            Carry_temp = 0;
            Overflow_temp = 0;
			end
		  `ALU_XOR:
			begin 
			C_temp2 = A^B;
            if(C_temp2==0)
                Zero_temp=1;
            else 
                Zero_temp=0;
            Carry_temp=0;
            Overflow_temp=0;
            if( C_temp2[31] == 1 )
               Negative_temp = 1;
            else if(C_temp2[31] == 0 )
               Negative_temp = 0;
			end 
		  `ALU_NOR:
			begin
			C_temp2 = ~(A|B);
            if( C_temp2 == 0 )
                Zero_temp = 1;
            else 
                Zero_temp = 0;
            Carry_temp=0;
            Overflow_temp=0;
            if(C_temp2[31]==1)
                Negative_temp=1;
            else if(C_temp2[31]==0)
				Negative_temp=0;
			end  
		  4'b1111: //ALU_SPADD
			begin
				C_temp = A + B;
				if( C_temp[31] == 1 )
					Negative_temp = 1;
				else if( C_temp[31] == 0 )
					Negative_temp = 0;
				Carry_temp=0;
				if ( A[31] & ~B[31]) Overflow_temp = 0; //A < 0, B >= 0, overflow = 0
				else if ( ~A[31] & B[31] )  Overflow_temp = 0; // A >= 0, B < 0, overflow = 0
				else if ( A[31] & B[31] & C_temp[31] ) Overflow_temp = 0; // A < 0, B < 0, C < 0, overflow = 0
				else if ( ~A[31] & ~B[31] & ~C_temp[31]) Overflow_temp = 0; // A >= 0, B >= 0, C >= 0, overflow = 0
				else begin
					Overflow_temp = 1;
					C_temp = 0;
					end
				if( C_temp == 0 )
					Zero_temp = 1;  
				else 
					Zero_temp = 0;
				C_temp2 = {C_temp[31:2],2'b00};
			end

		   default:   C_temp2 = A;                          // Undefined
	  endcase
	end // end always


	endmodule
    
