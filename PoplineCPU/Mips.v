//流水线处理器顶层文件
module Mips();
	
	reg clk,rst;
	
		initial begin
			//$readmemh( "C:/Users/xiye/Desktop/SCPU-student/extendedtest.dat" , U_IM.ins_mem); // load instructions into instruction memory
			//$readmemh( "mipstest_extloop.dat" , U_IM.ins_mem); // load instructions into instruction memory
			//$readmemh( "mipstestloopjal_sim.dat" , U_IM.ins_mem); // load instructions into instruction memory
			$readmemh( "C:/Users/xiye/Desktop/SCPU-student/mipstestloop_sim.dat" , U_IM.ins_mem); // load instructions into instruction memory
			clk = 1;
			rst = 0;
			#5 rst = 1;
			#5 rst = 0;
		end	
		
		always
			#(50) clk = ~clk;
			
//PC 
	wire[31:0] PC;
	wire[31:0] RS;
//NPC
	wire[31:0] NPC;	
//IM
	wire[6:0] IMAdd;
	wire[31:0] Ins;	
//RF
	wire[4:0] RegisterRd,RFWS,RFR1,RFR2;
	wire[31:0] RFDataIn;
	wire[31:0] RFDataOut1,RFDataOut2;
//Ext
	wire[15:0] EXTDataIn;
	wire[31:0] EXTDataOut;	
//DMem
	wire[6:0] DMAdd;
	wire[31:0] DMDataOut;
//Control
	wire[5:0] op;
	wire[5:0] funct;
	wire RegDst;
	wire MemRead;
	wire MemWrite;
	wire MemToReg;
	wire RegWrite;
	wire ALUsrc;
	wire ALUasrc;
	wire EXTOP;
	wire ShiftIndex;
	wire ShiftDirection;
	wire[1:0] NPCOp;
	wire[3:0] ALUop;
	wire call;

//ALU
	wire[31:0] ALUDataIn1;
	wire[31:0] ALUDataIn2;
	wire[31:0] ALUDataInA;
	wire[31:0] ALUDataInB;
	wire[31:0] ALUDataOut;

//Shifter
	wire[31:0] ShifterIn;
	wire[4:0] ShifterIndex;
	wire[31:0] ShifterOut;
//ForwardUnit
	wire[1:0] ForwardA;
	wire[1:0] ForwardB;
//else
	wire[31:0] preRFDataIn;

//if_id
	wire[31:0] id_pc;
	wire[31:0] id_inst;

//id_exe
	wire[31:0] exe_imm32;
	wire[31:0] exe_inst;
	wire[31:0] exe_RFRD1;
	wire[31:0] exe_RFRD2;
	wire[4:0] exe_RegisterRd;
	wire[4:0] exe_RegisterRs;
	wire[4:0] exe_RegisterRt;
	wire exe_RegDst;
	wire exe_MemRead;
	wire exe_MemtoReg;
	wire[3:0] exe_ALUOp;
	wire exe_MemWrite;
	wire exe_ALUSrc;
	wire exe_RegWrite;
	wire exe_ShiftIndex;
	wire exe_ShiftDirection;
	wire exe_ALUasrc;

//exe_mem
	wire[31:0] mem_inst;
	wire[31:0] mem_RFRD2;
	wire[31:0] mem_ALUOUT;
	wire[4:0] mem_RegisterRd;
	wire mem_RegDst;
	wire mem_MemRead;
	wire mem_MemtoReg;
	wire mem_MemWrite;
	wire mem_RegWrite;

//mem_wb
	wire[31:0] wb_inst;
	wire[31:0] wb_ALUOUT;
	wire[31:0] wb_MEMOUT;
	wire[4:0] wb_RegisterRd;
	wire wb_RegDst;
	wire wb_MemtoReg;
	wire wb_RegWrite;

	assign IMAdd = PC[8:2];
	assign op = id_inst[31:26];
	assign funct = id_inst[5:0];
	assign RFR1 = id_inst[25:21];
	assign RFR2 = id_inst[20:16];
	assign EXTDataIn = id_inst[15:0];
	assign ShifterIn = exe_RFRD2;
	assign RS = RFDataOut1;
	assign DMAdd = mem_ALUOUT[6:0];


//IF阶段
	//NPC实例化
		NPC U_Npc(.RS(RS),.PC(PC), .NPCOp(NPCOp), .IMM(EXTDataOut[25:0]), .NPC(NPC));

	//PC实例化
		PC U_Pc(.clk(clk),.rst(rst),.NPC(NPC),.PC(PC));
	
	//指令寄存器实例化
		instructionmemory U_IM(.IMAdd(IMAdd),.Ins(Ins));
	//IF-ID寄存器实例化
		if_id U_if_id(.clk(clk),.rst(rst),.if_pc(PC),.if_inst(Ins),.id_pc(id_pc),.id_inst(id_inst));

//ID阶段
	//TODO beq bne指令的判断
	//寄存器堆实例化
		//已修复BUG：RFWR输入信号错误 最初输入成RegWrite了 气死了！！！！
		RF U_Rf(.clk(clk),.rst(rst),.RFWr(wb_RegWrite),.A1(RFR1),.A2(RFR2),.A3(RFWS),.WD(RFDataIn),.RD1(RFDataOut1),.RD2(RFDataOut2));
	//控制器实例化
		Control U_Control(.Opcode(op),.Funct(funct),.RegDst(RegDst),.MemRead(MemRead),.MemtoReg(MemToReg),.ALUOp(ALUop),.MemWrite(MemWrite),.ALUSrc(ALUsrc),.RegWrite(RegWrite),.EXTOP(EXTOP),.NPCOP(NPCOp),.ShiftIndex(ShiftIndex),.ShiftDirection(ShiftDirection),.ALUasrc(ALUasrc),.call(call));
	//扩展器实例化
		EXT U_Ext(.Imm16(EXTDataIn),.EXTOp(EXTOP),.Imm32(EXTDataOut));
	//写寄存器2路选择器（一）用于确定是写入20-16位还是15-11位 其中控制信号为RegDst
		mux2_5 RD(id_inst[20:16],id_inst[15:11],RegDst,RegisterRd);
		//已修复BUG:20:16和15:11写反了
	//ID-EXE寄存器实例化
		id_exe U_id_exe(.clk(clk),.rst(rst),.id_inst(id_inst),.id_RFRD1(RFDataOut1),.id_RFRD2(RFDataOut2),.id_RegDst(RegDst),.id_MemRead(MemRead),.id_MemtoReg(MemToReg),.id_ALUOp(ALUop),.id_MemWrite(MemWrite),.id_ALUSrc(ALUsrc),.id_RegWrite(RegWrite),.id_ShiftIndex(ShiftIndex),.id_ShiftDirection(ShiftDirection),.id_ALUasrc(ALUasrc),.id_EXTOUT(EXTDataOut),.id_RegisterRd(RegisterRd),.id_RegisterRs(RFR1),.id_RegisterRt(RFR2),.exe_imm32(exe_imm32),.exe_inst(exe_inst),.exe_RFRD1(exe_RFRD1),.exe_RFRD2(exe_RFRD2),.exe_RegisterRd(exe_RegisterRd),.exe_RegisterRs(exe_RegisterRs),.exe_RegisterRt(exe_RegisterRt),.exe_RegDst(exe_RegDst),.exe_MemRead(exe_MemRead),.exe_MemtoReg(exe_MemtoReg),.exe_ALUOp(exe_ALUOp),.exe_MemWrite(exe_MemWrite),.exe_ALUSrc(exe_ALUSrc),.exe_RegWrite(exe_RegWrite),.exe_ShiftIndex(exe_ShiftIndex),.exe_ShiftDirection(exe_ShiftDirection),.exe_ALUasrc(exe_ALUasrc));

//EXE阶段    
	//移位器源操作数选择器 如果有移位操作则置位1 其中控制信号为ShiftIndex
		mux2_5 shift1(exe_inst[10:6],exe_RFRD1[4:0],exe_ShiftIndex,ShifterIndex);
	//移位器实例化
		Shifter U_Shifter(.orignial(exe_RFRD2),.index(ShifterIndex),.right(exe_ShiftDirection),.result(ShifterOut));
	//旁路控制单元
		ForwardUnit U_ForwardUnit(mem_RegWrite,wb_RegWrite,mem_RegisterRd,wb_RegisterRd,exe_RegisterRs,exe_RegisterRt,ForwardA,ForwardB);
	//ALU第一个操作数选择器(1)，从寄存器组中读出的第一个数据和移位器的数据中进行选择 
		mux2_32 alua(exe_RFRD1,ShifterOut,exe_ALUasrc,ALUDataIn1);
	//ALU第一个操作数选择器(2),从（1）和完全旁路中进行选择
		mux4_32 alua2(ALUDataIn1,RFDataIn,mem_ALUOUT,32'h00000000,ForwardA,ALUDataInA);
	//ALU第二个操作数选择器，从拓展后的imm和寄存器组中读出的第二个数进行选择
		mux2_32 alub(exe_RFRD2,exe_imm32,exe_ALUSrc,ALUDataIn2);
		//已修复BUG:直接传入了EXTDATAOUT
	//ALU第二个操作数选择器(2),从(2)和完全旁路中进行选择
		mux4_32 alub2(ALUDataIn2,RFDataIn,mem_ALUOUT,32'h00000000,ForwardB,ALUDataInB);
	//ALU实例化
		alu U_Alu(.A(ALUDataInA), .B(ALUDataInB), .ALUOp(exe_ALUOp), .C(ALUDataOut));
	//EXE-MEM寄存器实例化
		exe_mem U_exe_mem(clk,rst,exe_inst,exe_RFRD2,ALUDataOut,exe_RegisterRd,exe_RegDst,exe_MemRead,exe_MemtoReg,exe_MemWrite,exe_RegWrite,mem_inst,mem_RFRD2,mem_ALUOUT,mem_RegisterRd,mem_RegDst,mem_MemRead,mem_MemtoReg,mem_MemWrite,mem_RegWrite);

//MEM阶段
	//DM实例化
		datamemory U_Dmem(.DMAdd(DMAdd),.DataIn(mem_RFRD2),.DataOut(DMDataOut),.DMW(exe_MemWrite),.DMR(exe_MemRead),.clk(clk));
	//MEM-WB寄存器实例化
		mem_wb U_mem_wb(clk,rst,mem_inst,mem_ALUOUT,DMDataOut,mem_RegisterRd,mem_RegDst,mem_MemtoReg,mem_RegWrite,wb_inst,wb_ALUOUT,wb_MEMOUT,wb_RegisterRd,wb_RegDst,wb_MemtoReg,wb_RegWrite);

//WB阶段	

	//寄存器堆写操作数选择（一），从运算器和数据存储器的输出中进行选择
		mux2_32 outchoose(wb_ALUOUT,wb_MEMOUT,wb_MemtoReg,preRFDataIn);
	//写寄存器2路选择器（二）用于确定是写入一选择的寄存器还是31号寄存器 其中控制信号位Call
		mux2_5 rfw2(wb_RegisterRd,5'b11111,call,RFWS);
	//寄存器堆写操作数选择（二），从（一）和PC+4（仅jal|jalr指令）中选择
		mux2_32 rfDIn(preRFDataIn,PC+4,call,RFDataIn);
endmodule
	
//TODO 数据冒险 结构冒险