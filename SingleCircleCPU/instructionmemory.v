module instructionmemory(IMAdd,Ins);
	input[6:0] IMAdd; //由于指令存储器只能存128条指令。所以只需要这么多位PC就行了。
	output[31:0] Ins;
	
	reg[31:0] ins;
	reg[31:0] ins_mem[127:0];
	
	always@(IMAdd)
	begin
		ins = ins_mem[IMAdd];
	end
	assign Ins = ins;
endmodule