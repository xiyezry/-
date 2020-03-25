module datamemory(DMAdd,DataIn,DataOut,DMW,DMR,clk);
	input DMR;
	input DMW;
	input clk;
	input [31:0] DataIn;
	input [6:0] DMAdd;	
	output [31:0] DataOut;
	
	reg[31:0] data_mem[127:0];
	
	always@(posedge clk)
	begin
		if(DMW) //若写使能为1，则进行普通存储
			begin
			data_mem[DMAdd] <= DataIn;
			end
	end
	
	assign DataOut = data_mem[DMAdd];
endmodule