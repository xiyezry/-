module id_exe(  input clk,
                input rst,
                input[31:0]id_RFRD1,
                input[31:0]id_RFRD2,
                input id_RegDst,
                input id_MemRead,
                input id_MemtoReg,
                input[3:0]id_ALUOp,
                input id_MemWrite,
                input id_ALUSrc,
                input id_RegWrite,
                input id_ShiftIndex,
                input id_ShiftDirection,
                input id_ALUasrc,
                output reg[31:0] exe_RFRD1,
                output reg[31:0] exe_RFRD2,
                output reg exe_RegDst,
                output reg exe_MemRead,
                output reg exe_MemtoReg,
                output reg[3:0] exe_ALUOp,
                output reg exe_MemWrite,
                output reg exe_ALUSrc,
                output reg exe_RegWrite,
                output reg exe_ShiftIndex,
                output reg exe_ShiftDirection,
                output reg exe_ALUasrc)

    always @ (posedge clk)begin
        if(rst)
        begin
            exe_RFRD1 <=32'h00000000;
            exe_RFRD2 <=32'h00000000;
            exe_RegDst <=0
            exe_MemRead <=0
            exe_MemtoReg <=0
            exe_ALUOp <=4'b0000
            exe_MemWrite <=0
            exe_ALUSrc <=0
            exe_RegWrite <=0
            exe_ShiftIndex <=0
            exe_ShiftDirection <=0
            exe_ALUasrc <=0
        end
        else
        begin
                exe_RFRD1 <=id_RFRD1;
                exe_RFRD2 <= id_RFRD2;
                exe_RegDst <= id_RegDst;
                exe_MemRead <= id_MemRead;
                exe_MemtoReg <= id_MemtoReg;
                exe_ALUOp <= id_ALUOp;
                exe_MemWrite <= id_MemWrite;
                exe_ALUSrc <=id_ALUSrc;
                exe_RegWrite <= id_RegWrite;
                exe_ShiftIndex <= id_ShiftIndex;
                exe_ShiftDirection <= id_ShiftDirection;
                exe_ALUasrc <=id_ALUasrc;
        end
    end
endmodule