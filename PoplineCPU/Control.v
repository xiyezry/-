module Control(Opcode,Funct,RegDst,MemRead,MemtoReg,ALUOp,MemWrite,ALUSrc,RegWrite,EXTOP,NPCOP,Zero,ShiftIndex,ShiftDirection,ALUasrc,call);
	input [5:0] Opcode;    //指令操作码字段	
	input [5:0] Funct;     //指令功能码字段
	input Zero;            //零标志位，用于bne、beq条件的判断 从ALU中输入
	output RegDst;         //寄存器写输入选择 20-16为0,15-11为1.
	output MemRead;        //读数据存储器
	output MemtoReg;       //寄存器堆写操作数选择
	output MemWrite;       //写数据寄存器
	output RegWrite;       //寄存器写信号
	output ALUSrc;         //运算器B操作数选择
	output EXTOP;          //拓展操作信号；0为0拓展 1为符号拓展
	output [1:0] NPCOP;    //用以控制下一个输入PC指令的来源 00为PC+4;01为Branch；10为Jump；11则为直接从对应寄存器中读取指令
	output [3:0] ALUOp;    //ALU运算选择
	output ShiftIndex;     //选择移位器移动位数输入 0:Ins[10:6] 1:Ins[25:21]
	output ShiftDirection; //移位方向 1为右 2为左
	//output SArith;         //移位类型 1：算数移动 0：逻辑移动
	output ALUasrc;        //运算器A操作数选择 0则直接从寄存器中读取 1则经过移位器处理
	output call;           //约定jal jalr则call为1
	// output SpLoad;         //若为1 则表示为lh lb lhu lbu指令
	// output BorH;           //0代表字节 1代表半字
	// output SorU;           //1为unsigned 0为signed
	// output SpecialIn;      //0为正常情况 1则为半字或字节加载或储存
	// output DMemBorH;	   //用来判断存储指令为半字或者是字节


	//使用规约或非确定指令类型
	wire r_type = ~|Opcode;
	
	//如果是R型指令，则根据Funct，确定是哪一种R型指令
	wire i_add = r_type&Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&~Funct[1]&~Funct[0];
    wire i_sub = r_type&Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&Funct[1]&~Funct[0];
    wire i_and = r_type&Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&~Funct[1]&~Funct[0];
    wire i_or = r_type&Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&~Funct[1]&Funct[0];
	wire i_slt = r_type&Funct[5]&~Funct[4]&Funct[3]&~Funct[2]&Funct[1]&~Funct[0];
	wire i_sltu = r_type&Funct[5]&~Funct[4]&Funct[3]&~Funct[2]&Funct[1]&Funct[0];
	wire i_addu = r_type&Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&~Funct[1]&Funct[0];
	wire i_subu = r_type&Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&Funct[1]&Funct[0];	
	//wire i_xor = r_type&Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&Funct[1]&~Funct[0];
    wire i_sll = r_type&~Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&~Funct[1]&~Funct[0];
	wire i_sllv = r_type&~Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&~Funct[1]&~Funct[0];
	wire i_nor = r_type&Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&Funct[1]&Funct[0];
    wire i_srl = r_type&~Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&Funct[1]&~Funct[0];
	wire i_srlv = r_type&~Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&Funct[1]&~Funct[0];
    //wire i_sra = r_type&~Funct[5]&~Funct[4]&~Funct[3]&~Funct[2]&Funct[1]&Funct[0];
    wire i_jr = r_type&~Funct[5]&~Funct[4]&Funct[3]&~Funct[2]&~Funct[1]&~Funct[0];
	wire i_jalr = r_type&~Funct[5]&~Funct[4]&Funct[3]&~Funct[2]&~Funct[1]&Funct[0];
	//wire i_srav = r_type&~Funct[5]&~Funct[4]&~Funct[3]&Funct[2]&Funct[1]&Funct[0];
	
	
	//如果不是R型指令，则根据Opcode，确定是哪一种指令
	wire i_addi = ~Opcode[5]&~Opcode[4]&Opcode[3]&~Opcode[2]&~Opcode[1]&~Opcode[0];
    wire i_ori = ~Opcode[5]&~Opcode[4]&Opcode[3]&Opcode[2]&~Opcode[1]&Opcode[0];
    wire i_lw = Opcode[5]&~Opcode[4]&~Opcode[3]&~Opcode[2]&Opcode[1]&Opcode[0];
    wire i_sw = Opcode[5]&~Opcode[4]&Opcode[3]&~Opcode[2]&Opcode[1]&Opcode[0];
    wire i_beq = ~Opcode[5]&~Opcode[4]&~Opcode[3]&Opcode[2]&~Opcode[1]&~Opcode[0];
    wire i_j = ~Opcode[5]&~Opcode[4]&~Opcode[3]&~Opcode[2]&Opcode[1]&~Opcode[0];	
	wire i_jal = ~Opcode[5]&~Opcode[4]&~Opcode[3]&~Opcode[2]&Opcode[1]&Opcode[0];
	wire i_bne = ~Opcode[5]&~Opcode[4]&~Opcode[3]&Opcode[2]&~Opcode[1]&Opcode[0];
    wire i_lui = ~Opcode[5]&~Opcode[4]&Opcode[3]&Opcode[2]&Opcode[1]&Opcode[0];
	wire i_andi = ~Opcode[5]&~Opcode[4]&Opcode[3]&Opcode[2]&~Opcode[1]&~Opcode[0];
	wire i_slti = ~Opcode[5]&~Opcode[4]&Opcode[3]&~Opcode[2]&Opcode[1]&~Opcode[0];
	//wire i_lb = Opcode[5]&~Opcode[4]&~Opcode[3]&~Opcode[2]&~Opcode[1]&~Opcode[0];
	//wire i_lbu = Opcode[5]&~Opcode[4]&~Opcode[3]&Opcode[2]&~Opcode[1]&~Opcode[0];
	//wire i_lh = Opcode[5]&~Opcode[4]&~Opcode[3]&~Opcode[2]&~Opcode[1]&Opcode[0];
	//wire i_lhu = Opcode[5]&~Opcode[4]&~Opcode[3]&Opcode[2]&~Opcode[1]&Opcode[0]; 
	//wire i_sb = Opcode[5]&~Opcode[4]&Opcode[3]&~Opcode[2]&~Opcode[1]&~Opcode[0];
	//wire i_sh = Opcode[5]&~Opcode[4]&Opcode[3]&~Opcode[2]&~Opcode[1]&Opcode[0];
	
	
	assign call = i_jal|i_jalr;
	assign NPCOP[0] = i_beq&Zero|i_bne&~Zero|i_jr|i_jalr;
	assign NPCOP[1] = i_j|i_jal|i_jr|i_jalr;
	assign RegDst = i_add|i_sub|i_and|i_or|i_slt|i_sltu|i_addu|i_subu|i_nor|i_sll|i_sllv|i_srl|i_srlv;
	assign MemRead = i_lw;
	assign MemtoReg = i_lw;
	assign MemWrite = i_sw;
	assign RegWrite = i_lw|i_add|i_sub|i_and|i_or|i_slt|i_sltu|i_addu|i_subu|i_addi|i_ori|i_nor|i_lui|i_andi|i_slti|i_sll|i_sllv|i_srl|i_srlv|i_jalr|i_jal;
	assign ALUSrc = i_addi|i_ori|i_lw|i_sw|i_andi|i_slti;
	assign ALUOp[3] = i_nor|i_lui;
	assign ALUOp[2] = i_or|i_slt|i_sltu|i_ori|i_nor|i_lui|i_slti;
	assign ALUOp[1] = i_sub|i_and|i_sltu|i_subu|i_beq|i_nor|i_andi|i_bne;
	assign ALUOp[0] = i_add|i_and|i_slt|i_addu|i_addi|i_lw|i_sw|i_andi|i_slti;
	assign EXTOP = i_addi|i_lw|i_sw;
	assign ShiftIndex = i_sllv|i_srlv;
	assign ShiftDirection = i_srl|i_srlv; 
	assign ALUasrc = i_sll|i_sllv|i_srl|i_srlv; 

	
endmodule