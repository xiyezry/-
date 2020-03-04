module datamemory(DMAdd,DataIn,DataOut,DMW,DMR,clk);
	input [31:0] DataIn;
	input [6:0] DMAdd;
	input DMR;
	input DMW;
	input clk;
	
	output [31:0] DataOut;
	
	reg[31:0] data_mem[127:0];
	
	always@(posedge clk)
	begin
		if(DMW)
			data_mem[DMAdd] <= DataIn;
	end
	
	assign DataOut = data_mem[DMAdd];
endmodule