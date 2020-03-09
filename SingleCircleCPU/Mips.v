module Mips();
	
	reg clk,rst;
	
		initial begin
			$readmemh( "C:/Users/xiye/Desktop/SCPU-student/extendedtest.dat" , U_IM.ins_mem); // load instructions into instruction memory
			
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
	wire[4:0] rfws,RFWS,RFR1,RFR2;
	wire[31:0] RFDataIn;
	wire[31:0] RFDataOut1,RFDataOut2;
	
//Ext
	wire[31:0] EXTDataIn;
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
	wire SArith;
	wire[1:0] NPCOp;
	wire[3:0] ALUop;
	wire call;
	wire Spload;
	wire BorH;
	wire SorU;
	wire SpecialIn;
	wire DMemBorH;
	
//ALU
	wire[31:0] ALUDataIn1;
	wire[31:0] ALUDataIn2;
	wire[31:0] ALUDataOut;
	wire zero;
	wire carry;
	wire negative;
	wire overflow;
	wire[1:0] LastTwo;
	
//Shifter
	wire[31:0] ShifterIn;
	wire[4:0] ShifterIndex;
	wire[31:0] ShifterOut;
	
	wire[31:0] preRFDataIn;
	wire[7:0] LoadbyteOut;
	wire[15:0] LoadhalfOut;
	wire[31:0] ByteEXTOut;
	wire[31:0] HalfEXTOut;
	wire[31:0] LoadEXTOut;
	wire[31:0] LoadOrNotOut;
	
//NPC实例化
	NPC U_Npc(.RS(RS),.PC(PC), .NPCOp(NPCOp), .IMM(EXTDataOut), .NPC(NPC));

//PC实例化
	PC U_Pc(.clk(clk),.rst(rst),.NPC(NPC),.PC(PC));
	
	assign IMAdd = PC[8:2];
	
//指令寄存器实例化
	instructionmemory U_IM(.IMAdd(IMAdd),.Ins(Ins));
	
	assign op = Ins[31:26];
	assign funct = Ins[5:0];
	assign RFR1 = Ins[25:21];
	assign RFR2 = Ins[20:16];
	
	mux2_5 rfw1(Ins[20:16],Ins[15:11],RegDst,rfws);
	//assign RFWS = (RegDst==1)?Ins[15:11]:Ins[20:16];
	
	assign EXTDataIn = Ins[15:0];

//寄存器堆实例化
	RF U_Rf(.clk(clk),.rst(rst),.RFWr(RegWrite),.A1(RFR1),.A2(RFR2),.A3(RFWS),.WD(RFDataIn),.RD1(RFDataOut1),.RD2(RFDataOut2));
	
	assign ShifterIn = RFDataOut2;
	assign RS = RFDataOut1;
	
//控制器实例化
	Control U_Control(.Opcode(op),.Funct(funct),.RegDst(RegDst),.MemRead(MemRead),.MemtoReg(MemToReg),.ALUOp(ALUop),.MemWrite(MemWrite),.ALUSrc(ALUsrc),.RegWrite(RegWrite),.EXTOP(EXTOP),.NPCOP(NPCOp),.Zero(zero),.ShiftIndex(ShiftIndex),.ShiftDirection(ShiftDirection),.SArith(SArith),.ALUasrc(ALUasrc),.call(call),.SpLoad(Spload),.BorH(BorH),.SorU(SorU),.SpecialIn(SpecialIn),.DMemBorH(DMemBorH));

//扩展器实例化
	EXT U_Ext(.Imm16(EXTDataIn),.EXTOp(EXTOP),.Imm32(EXTDataOut));
	//TODO
	EXT_8 U_ByteEXT(LoadbyteOut,SorU,ByteEXTOut);
	EXT U_HalfEXT(LoadhalfOut,SorU,HalfEXTOut);
	
	mux2_32 alub(RFDataOut2,EXTDataOut,ALUsrc,ALUDataIn2);
	//assign ALUDataIn2 = (ALUsrc==1)?EXTDataOut:RFDataOut2;
	
	mux2_5 shift1(Ins[10:6],Ins[25:21],ShiftIndex,ShifterIndex);
//移位器实例化
	Shifter U_Shifter(.orignial(ShifterIn),.index(ShifterIndex),.right(ShiftDirection),.arith(SArith),.result(ShifterOut));
	
	mux2_32 alua(RFDataOut1,ShifterOut,ALUasrc,ALUDataIn1);
	//assign ALUDataIn1 = (ALUasrc==1)?ShifterOut:RFDataOut1;
//ALU实例化
	alu U_Alu(.A(ALUDataIn1), .B(ALUDataIn2), .ALUOp(ALUop), .C(ALUDataOut), .Zero(zero),.Carry(carry),.Negative(negative),.Overflow(overflow),.LastTwo(LastTwo));
	
	mux2_32 outchoose(ALUDataOut,DMDataOut,MemToReg,preRFDataIn);
//DM实例化
	assign DMAdd = ALUDataOut[6:0];
	datamemory U_Dmem(.SpecialIn(SpecialIn),.BorH(DMemBorH),.LastTwo(LastTwo),.DMAdd(DMAdd),.DataIn(RFDataOut2),.DataOut(DMDataOut),.DMW(MemWrite),.DMR(MemRead),.clk(clk));
	
	mux2_32 rfDIn(LoadOrNotOut,PC+4,call,RFDataIn);
	mux2_5 rfw2(rfws,5'b11111,call,RFWS);
	mux4 loadbyte(preRFDataIn[7:0],preRFDataIn[15:8],preRFDataIn[23:16],preRFDataIn[31:24],ALUDataOut[1:0],LoadbyteOut);
	mux2_16 loadhalf(preRFDataIn[15:0],preRFDataIn[31:16],ALUDataOut[1],LoadhalfOut);
	mux2_32 loadExtOut(ByteEXTOut,HalfEXTOut,BorH,LoadEXTOut);
	mux2_32 LoadOrNot(preRFDataIn,LoadEXTOut,Spload,LoadOrNotOut);

endmodule
	
	