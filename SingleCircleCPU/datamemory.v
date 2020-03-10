module datamemory(SpecialIn,BorH,LastTwo,DMAdd,DataIn,DataOut,DMW,DMR,clk);
	input SpecialIn;
	input BorH;
	input[1:0] LastTwo;
	input [31:0] DataIn;
	input [6:0] DMAdd;
	input DMR;
	input DMW;
	input clk;
	
	output [31:0] DataOut;
	
	reg[31:0] data_mem[127:0];
	
	always@(posedge clk)
	begin
		if(DMW && !SpecialIn)
			begin
			data_mem[DMAdd] <= DataIn;
			end
		else if(DMW && SpecialIn && !BorH)
			begin
				case (LastTwo)
					2'b00: data_mem[DMAdd][7:0] <=DataIn[7:0];
					2'b01: data_mem[DMAdd][15:8] <=DataIn[7:0];
					2'b10: data_mem[DMAdd][23:16] <=DataIn[7:0];
					2'b11: data_mem[DMAdd][31:24] <=DataIn[7:0];
					default: data_mem[DMAdd] = data_mem[DMAdd];
				endcase
			end
		else if(DMW && SpecialIn&& BorH)
			begin
				case (LastTwo[1])
					1'b0: data_mem[DMAdd][15:0] <=DataIn[15:0];
					1'b1: data_mem[DMAdd][31:16] <=DataIn[15:0];
					default: data_mem[DMAdd] = data_mem[DMAdd];
				endcase
			end
	end

	assign DataOut = data_mem[DMAdd];
endmodule