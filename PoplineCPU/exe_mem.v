module exe_mem( input clk,
                input rst,
                input[31:0] exe_inst,
                input [31:0] exe_RFRD2,
                input  [31:0] exe_ALUOUT,
                input [4:0] exe_RegisterRd,
                input  exe_RegDst,
                input  exe_MemRead,
                input  exe_MemtoReg,
                input  exe_MemWrite,
                input  exe_RegWrite,
                output  reg[31:0] mem_inst,
                output  reg[31:0] mem_RFRD2,
                output  reg[31:0] mem_ALUOUT,
                output  reg[4:0] mem_RegisterRd,
                output  reg mem_RegDst,
                output  reg mem_MemRead,
                output  reg mem_MemtoReg,
                output  reg mem_MemWrite,
                output  reg mem_RegWrite);

    always @ (posedge clk) begin
        if(rst)
        begin
            mem_inst   <= 32'h00000000;
            mem_RFRD2  <= 32'h00000000;
            mem_ALUOUT <= 32'h00000000;
            mem_RegisterRd <= 5'b00000;
            mem_RegDst <= 0;
            mem_MemRead <= 0;
            mem_MemtoReg <= 0;
            mem_MemWrite <= 0;
            mem_RegWrite <= 0;
        end
        else
        begin
            mem_inst <= exe_inst;
            mem_RFRD2 <= exe_RFRD2;
            mem_ALUOUT <= exe_ALUOUT;
            mem_RegisterRd <= exe_RegisterRd;
            mem_RegDst <= exe_RegDst;
            mem_MemRead <= exe_MemRead;
            mem_MemtoReg <= exe_MemtoReg;
            mem_MemWrite <= exe_MemWrite;
            mem_RegWrite <= exe_RegWrite;
        end
    end
endmodule
                